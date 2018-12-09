package gestion_equipos_controlados

import grails.validation.ValidationException

class EquipoController {

    def index() { }

    def crear(){
        respond new Equipo(params)
    }

    def save(Equipo equipo){
        try {
            equipo.save(flush: true, failOnError: true)
            redirect(controller: 'equipo', action: 'index')
        } catch (ValidationException e) {
            respond equipo.errors, view: 'crear'
        }
    }

    def verificarNombreEquipo(){
        render Equipo.findByNombre(params.data as String) ? true : false
    }
}
