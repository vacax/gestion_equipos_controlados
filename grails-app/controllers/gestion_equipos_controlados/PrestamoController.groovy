package gestion_equipos_controlados

import grails.converters.JSON
import org.springframework.security.access.annotation.Secured

import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN'])
class PrestamoController {
  
  SimpleDateFormat sdf = new SimpleDateFormat('dd/MM/yyyy')
  
  def recibir(){
        def prestamo = Prestamo.findByNombreEstudiante("Stanley De Moya")
        /*
        prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PENDIENTE)
        prestamo.listaPrestamoDetalle.each {
            it.entregado = false
            it.save(flush:true, failOnError:true)
        }
        prestamo.save(flush:true, failOnError:true)
        */
        [prestamo : prestamo]
  }

    def recibirTodo(long prestamo){

        def prestamoTmp = Prestamo.findById(prestamo)
        prestamoTmp.listaPrestamoDetalle.each {
            it.entregado = true
            it.equipoSerial.prestado = false
            it.save(flush: true, failOnError: true)
        }
        prestamoTmp.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
        prestamoTmp.save(flush:true, failOnError:true)
        // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
        redirect(controller: 'prestamo', action: 'recibir')
    }

    def recibirParcial(long prestamoDetalle){


            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
            def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
            equipoSerialTmp.prestado = false
            prestamoDetalleTmp.entregado = true
            equipoSerialTmp.save(flush: true, failOnError: true)
            prestamoDetalleTmp.save(flush: true, failOnError: true)

            def prestamoCompleto = prestamo.listaPrestamoDetalle.every{ it.entregado }
            if(prestamoCompleto){
                prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
                prestamo.save(flush: true, failOnError: true)
            }
            // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
            redirect(controller: 'prestamo', action: 'recibir')

    }

    def recibirParcialProblema(long prestamoDetalle){

        try{
            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
            def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
            def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
            def salidaEquipo = new Movimiento()

            equipoSerialTmp.prestado = false
            equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.DANADO)
            prestamoDetalleTmp.entregado = true
            equipoSerialTmp.save(flush: true, failOnError: true)
            prestamoDetalleTmp.save(flush: true, failOnError: true)

            salidaEquipo.equipo = equipo
            salidaEquipo.cantidad = 1
            salidaEquipo.tipoMovimiento = Movimiento.TipoMovimiento.SALIDA
            salidaEquipo.save(flush: true, failOnError: true)

            equipo.cantidadTotal -= 1
            equipo.cantidadDisponible -= 1
            equipo.save(flush: true, failOnError:true)

            def prestamoCompleto = prestamo.listaPrestamoDetalle.every{it.entregado}
            if(prestamoCompleto){
                prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
                prestamo.save(flush: true, failOnError: true)
            }

            redirect(controller: 'prestamo', action: 'recibir')
        }
        catch (Exception e){

        }
    }

    

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
            def dataEstudiante = JSON.parse(params.estudiante)
            prestamo.nombreEstudiante = dataEstudiante['nombre']
            prestamo.matriculaEstudiante = dataEstudiante['matricula']
            prestamo.fechaEntrega = sdf.parse(dataEstudiante['fechaEntrega'] as String)

            prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO)
            prestamo.listaPrestamoDetalle = new HashSet<>()
            def dataPrestamo = JSON.parse(params.dataPrestamo)
            dataPrestamo.each {
                def detalle = new PrestamoDetalle()
                detalle.cantidadPrestado = it['cantidad'] as int
                def equipoSerial = EquipoSerial.findBySerial(it['serial'] as String)
                if (!equipoSerial.prestado) {
                    detalle.equipoSerial = equipoSerial
                    equipoSerial.equipo.cantidadDisponible--
                    equipoSerial.prestado = true

                    equipoSerial.save(flush: true, failOnError: true)
                    equipoSerial.equipo.save(flush: true, failOnError: true)
                    detalle.save(flush: true, failOnError: true)

                    prestamo.listaPrestamoDetalle.add(detalle)
                    ok = true
                } else {
                    ok = false
                }
            }

            if (ok) {
                prestamo.save(flush: true, failOnError: true)
                resp = true
            }

        } catch (Exception e) {
            println e.message
        }
        render resp
    }

    def historial() {
        ['prestamos': Prestamo.findAll()]
    }
}
