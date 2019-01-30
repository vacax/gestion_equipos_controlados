package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.gorm.transactions.Transactional

import java.text.SimpleDateFormat

@Transactional
class PrestamoService {

    def save(def dataEstudiante, dataPrestamo, User currentUser) {
        SimpleDateFormat sdf = new SimpleDateFormat('dd/MM/yyyy')
        def prestamo = new Prestamo()

        prestamo.nombreEstudiante = dataEstudiante['nombre']
        prestamo.matriculaEstudiante = dataEstudiante['matricula']
        prestamo.fechaEntrega = sdf.parse(dataEstudiante['fechaEntrega'] as String)
        prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO)
        prestamo.observacion = dataEstudiante['observacion'] != "" ? dataEstudiante['observacion'] : " "
        prestamo.save(flush: true, failOnError: true)
        prestamo.listaPrestamoDetalle = new HashSet<>()

        dataPrestamo.each {
            if (it['idEquipoSerial'] != null) {
                def detalle = new PrestamoDetalle()
                def eqSerial = EquipoSerial.findById(it['idEquipoSerial'] as long)
                eqSerial.equipo.cantidadDisponible--
                eqSerial.prestado = true
                eqSerial.save(flush: true, failOnError: true)
                eqSerial.equipo.save(flush: true, failOnError: true)

                detalle.equipoSerial = eqSerial
                detalle.prestamo = prestamo
                detalle.cantidadPrestado = it['cantidad'] as int
                detalle.usuarioEntrega = currentUser
                detalle.save(flush: true, failOnError: true)
                prestamo.listaPrestamoDetalle.add(detalle)
            } else {
                for (int i = 0; i < (it['cantidad'] as int); i++) {
                    def detalle = new PrestamoDetalle()
                    def eqSerialRandom = EquipoSerial.findByEquipoAndPrestado(Equipo.findById(it['idEquipo'] as long), false)
                    eqSerialRandom.equipo.cantidadDisponible--
                    eqSerialRandom.prestado = true
                    eqSerialRandom.save(flush: true, failOnError: true)
                    eqSerialRandom.equipo.save(flush: true, failOnError: true)

                    detalle.equipoSerial = eqSerialRandom
                    detalle.prestamo = prestamo
                    detalle.cantidadPrestado = 1
                    detalle.usuarioEntrega = currentUser
                    detalle.save(flush: true, failOnError: true)
                    prestamo.listaPrestamoDetalle.add(detalle)
                }
            }
        }
        prestamo.save(flush: true, failOnError: true)
    }

    def recibirTodo(long prestamoId, User currentUser) {
        def prestamoTmp = Prestamo.findById(prestamoId)
        prestamoTmp.listaPrestamoDetalle.each {
            if (!it.entregado) {
                def equipo = Equipo.findById(it.equipoSerial.equipo.id)
                equipo.cantidadDisponible += 1
                it.entregado = true
                it.equipoSerial.prestado = false
                it.usuarioRecibo = currentUser
                it.fechaRecibo = new Date()

                equipo.save(flush: true, failOnError: true)
                it.save(flush: true, failOnError: true)
            }
        }
        prestamoTmp.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
        prestamoTmp.save(flush: true, failOnError: true)
    }

    def recibirParcial(PrestamoDetalle prestamoDetalle, User currentUser) {
        def equipoSerialTmp = EquipoSerial.findById(prestamoDetalle.equipoSerial.id)
        def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
        def prestamo = Prestamo.findById(prestamoDetalle.prestamo.id)
        equipo.cantidadDisponible += 1
        equipoSerialTmp.prestado = false
        prestamoDetalle.entregado = true
        prestamoDetalle.usuarioRecibo = currentUser
        prestamoDetalle.fechaRecibo = new Date()

        equipo.save(flush: true, failOnError: true)
        equipoSerialTmp.save(flush: true, failOnError: true)
        prestamoDetalle.save(flush: true, failOnError: true)

        def prestamoCompleto = prestamo.listaPrestamoDetalle.every { it.entregado }
        if (prestamoCompleto) {
            prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
            prestamo.save(flush: true, failOnError: true)
        }
    }

    def recibirParcialProblema(PrestamoDetalle prestamoDetalle, User currentUser, boolean perdido) {
        def equipoSerialTmp = EquipoSerial.findById(prestamoDetalle.equipoSerial.id)
        def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
        def prestamo = Prestamo.findById(prestamoDetalle.prestamo.id)
        def salidaEquipo = new Movimiento()

        equipoSerialTmp.prestado = false
        if (!perdido) {
            equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.DANADO)
            prestamoDetalle.nota = "DAÑADO"
        } else {
            equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.PERDIDO)
            prestamoDetalle.nota = "PERDIDO"
        }
        prestamoDetalle.entregado = true
        prestamoDetalle.usuarioRecibo = currentUser
        prestamoDetalle.fechaRecibo = new Date()

        equipoSerialTmp.save(flush: true, failOnError: true)
        prestamoDetalle.save(flush: true, failOnError: true)

        salidaEquipo.equipo = equipo
        salidaEquipo.cantidad = 1
        salidaEquipo.tipoMovimiento = Movimiento.TipoMovimiento.SALIDA
        salidaEquipo.save(flush: true, failOnError: true)

        equipo.cantidadTotal -= 1
        equipo.cantidadDisponible -= 1
        equipo.save(flush: true, failOnError: true)

        def prestamoCompleto = prestamo.listaPrestamoDetalle.every { it.entregado }
        if (prestamoCompleto) {
            prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
            prestamo.save(flush: true, failOnError: true)
        }

    }
}
