package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class MovimientoController {

    MovimientoService movimientoService
    def springSecurityService

    def index() {
        def listadoMovimientos = Movimiento.findAllByHabilitado(true)
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoMovimientos: listadoMovimientos, listadoEquipos: listadoEquipos]
    }

    def crearEntrada() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos: listadoEquipos]
    }

    def crearSalida() {
        def listadoEquipos = EquipoSerial.findAllByHabilitadoAndPrestado(true, false)
        [listadoEquipos: listadoEquipos]
    }

    def guardarEntrada() {
        def movimiento = null
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            movimiento = movimientoService.guardarEntrada(params.equipo as long,
                    params.cantidad as int, params.serial, params.comentario, currentUser)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearEntrada'
        }
    }

    def guardarSalida() {
        def movimiento = null

        try {
            movimiento = movimientoService.guardarSalida(params.data as long)
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearSalida'
        }
    }

    def verificarNecesitaSerial() {
        def equipo = Equipo.findById(params.data as long)
        if (equipo != null)
            render equipo.serial
        else
            render 'null'
    }

}
