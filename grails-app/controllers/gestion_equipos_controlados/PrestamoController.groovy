package gestion_equipos_controlados

import grails.converters.JSON

import java.text.SimpleDateFormat

class PrestamoController {

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

                    equipoSerial.save(flush:true, failOnError: true)
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

    def historial(){
        ['prestamos': Prestamo.findAll()]
    }
}
