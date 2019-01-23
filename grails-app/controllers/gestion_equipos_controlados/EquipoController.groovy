package gestion_equipos_controlados

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

@Secured(['ROLE_ADMIN'])
class EquipoController {

    EquipoService equipoService

    def index() {}

    def crear() {
        respond new Equipo(params)
    }

    def save(Equipo equipo) {
        try {
            equipoService.save(equipo)
            redirect(controller: 'equipo', action: 'index')
        } catch (ValidationException e) {
            println equipo.errors
            respond equipo.errors, view: 'crear'
        }
    }

    def verificarNombreEquipo() {
        render Equipo.findByNombre(params.data as String) ? true : false
    }

    def edit(long equipo) {
        def equipoTmp = Equipo.findById(equipo)
        [equipo: equipoTmp]
    }

    def modificarEquipo(long idEquipo, String nombre, long categoriaEquipo) {

        withForm {
            equipoService.update(idEquipo, nombre, categoriaEquipo)
        }.invalidToken {
            println("Doble posteo detectado...")
        }

        redirect(action: "index")
    }
}
