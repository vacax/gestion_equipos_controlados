package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import org.springframework.security.access.annotation.Secured

import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN'])
class PrestamoController {

    SpringSecurityService springSecurityService
    SimpleDateFormat sdf = new SimpleDateFormat('dd/MM/yyyy')

    def index() {
        ['prestamos': Prestamo.findAllByEstadoPrestamo(EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))]
    }

    def crear() {
        respond new Prestamo(params)
    }

    def save() {
        def ok = false
        def resp = false

        try {
            def prestamo = new Prestamo()
            try {
                def dataEstudiante = JSON.parse(params.estudiante)
                prestamo.nombreEstudiante = dataEstudiante['nombre']
                prestamo.matriculaEstudiante = dataEstudiante['matricula']
                prestamo.fechaEntrega = sdf.parse(dataEstudiante['fechaEntrega'] as String)
                prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO)
                prestamo.save(flush: true, failOnError: true)
                prestamo.listaPrestamoDetalle = new HashSet<>()
                def dataPrestamo = JSON.parse(params.dataPrestamo)

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
                        detalle.usuarioEntrega = (User) springSecurityService.getCurrentUser()
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
                            detalle.usuarioEntrega = (User) springSecurityService.getCurrentUser()
                            detalle.save(flush: true, failOnError: true)
                            prestamo.listaPrestamoDetalle.add(detalle)
                        }
                    }
                    ok = true
                }
                prestamo.save(flush: true, failOnError: true)
            } catch (Exception e) {
                println e.message
                ok = false
            }
        } catch (Exception e) {
            println e.message
        }

        if (ok) {
            resp = true
        }
        render resp
    }

    def historial() {
        ['prestamos': Prestamo.findAll()]
    }

    def recibir(long prestamo) {
        def prestamoTmp = Prestamo.findById(prestamo)
        /*
        prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PENDIENTE)
        prestamo.listaPrestamoDetalle.each {
            it.entregado = false
            it.save(flush:true, failOnError:true)
        }
        prestamo.save(flush:true, failOnError:true)
        */
        [prestamo: prestamoTmp]
    }

    def recibirTodo(long prestamo) {

        def prestamoTmp = Prestamo.findById(prestamo)
        prestamoTmp.listaPrestamoDetalle.each {
            if (!it.entregado) {
                def equipo = Equipo.findById(it.equipoSerial.equipo.id)
                equipo.cantidadDisponible += 1
                it.entregado = true
                it.equipoSerial.prestado = false
                it.usuarioRecibo =  (User) springSecurityService.getCurrentUser();

                equipo.save(flush: true, failOnError: true)
                it.save(flush: true, failOnError: true)
            }
        }
        prestamoTmp.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
        prestamoTmp.save(flush: true, failOnError: true)
        // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
        redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamoTmp.id])
    }

    def recibirParcial() {

        def prestamoDetalleTmp = PrestamoDetalle.findById(params.prestamoDetalle as long)
        def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
        def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
        def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
        equipo.cantidadDisponible += 1
        equipoSerialTmp.prestado = false
        prestamoDetalleTmp.entregado = true
        prestamoDetalleTmp.usuarioRecibo =  (User) springSecurityService.getCurrentUser()

        equipo.save(flush: true, failOnError: true)
        equipoSerialTmp.save(flush: true, failOnError: true)
        prestamoDetalleTmp.save(flush: true, failOnError: true)

        def prestamoCompleto = prestamo.listaPrestamoDetalle.every { it.entregado }
        if (prestamoCompleto) {
            prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
            prestamo.save(flush: true, failOnError: true)
        }
        // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
        redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamoDetalleTmp.prestamo.id])

    }

    def recibirParcialProblema(long prestamoDetalle, boolean perdido) {

        try {
            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
            def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
            def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
            def salidaEquipo = new Movimiento()

            equipoSerialTmp.prestado = false
            if (!perdido){
                equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.DANADO)
            }
            else {
                equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.PERDIDO)
            }
            prestamoDetalleTmp.entregado = true
            prestamoDetalleTmp.usuarioRecibo =  (User) springSecurityService.getCurrentUser()

            equipoSerialTmp.save(flush: true, failOnError: true)
            prestamoDetalleTmp.save(flush: true, failOnError: true)

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

            redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamoDetalleTmp.prestamo.id])
        }
        catch (Exception e) {
            println e.message
        }
    }
}
