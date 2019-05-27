package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_MOVIMIENTO'])
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

    def guardarEntrada(long equipo, int cantidad, String serial, String comentario) {
        def movimiento = null
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            movimiento = movimientoService.guardarEntrada(equipo,
                    cantidad, serial, comentario, currentUser)
            redirect(controller: 'movimiento', action: 'index')
        }catch (Exception e) {
            respond movimiento?.errors, view: 'crearEntrada'
        }
    }

    /**
     * 
     * @param data
     * @return
     */
    def guardarSalida(long data) {
        def movimiento = null

        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            movimiento = movimientoService.guardarSalida(data , currentUser)
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearSalida'
        }
    }

    /**
     * 
     * @param data
     * @return
     */
    def verificarNecesitaSerial(long data) {
        def equipo = Equipo.findById(data)
        if (equipo != null)
            render equipo.serial
        else
            render 'null'
    }

}
