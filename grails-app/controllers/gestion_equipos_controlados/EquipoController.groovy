package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_EQUIPO'])
class EquipoController {

    EquipoService equipoService
    def springSecurityService

    def index() {}

    def crear() {
        respond new Equipo(params)
    }

    def save(Equipo equipo) {
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            equipoService.save(equipo, currentUser)
            redirect(controller: 'equipo', action: 'index')
        } catch (ValidationException e) {
            println equipo.errors
            respond equipo.errors, view: 'crear'
        }
    }

    def verificarNombreEquipo() {
        render Equipo.findByNombre(params.data as String) ? true : false
    }

    def edit(long id) {
        def equipoTmp = Equipo.findById(id)
        [equipo: equipoTmp]
    }

    def modificarEquipo(long idEquipo, String nombre, long categoriaEquipo, boolean habilitado) {
        def currentUser = (User) springSecurityService.getCurrentUser()

        withForm {
            equipoService.update(idEquipo, nombre, categoriaEquipo, habilitado, currentUser)
        }.invalidToken {
            println("Doble posteo detectado...")
        }

        redirect(action: "index")
    }

}
