package gestion_equipos_controlados

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

@Secured(['ROLE_ADMIN'])
class EquipoController {

    def index() {}

    def crear() {
        respond new Equipo(params)
    }

    def save(Equipo equipo) {
        try {
            equipo.save(flush: true, failOnError: true)
            def movimiento = new Movimiento()
            movimiento.equipo = equipo
            movimiento.cantidad = params.cantidadTotal as int
            equipo.cantidadDisponible = equipo.cantidadTotal
            movimiento.tipoMovimiento = Movimiento.TipoMovimiento.ENTRADA
            if (equipo.serial && params.serial != null) {
                params.serial.each {
                    new EquipoSerial(equipo: equipo, serial: it).save(flush: true, failOnError: true)
                }
            }
            movimiento.save(flush:true, failOnError: true)
            redirect(controller: 'equipo', action: 'index')
        } catch (ValidationException e) {
            println equipo.errors
            respond equipo.errors, view: 'crear'
        }
    }

    def verificarNombreEquipo() {
        render Equipo.findByNombre(params.data as String) ? true : false
    }
}
