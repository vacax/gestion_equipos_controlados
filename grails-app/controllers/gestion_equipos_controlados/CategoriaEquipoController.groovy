package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.validation.ValidationException
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_CATEGORIA_EQUIPO'])
class CategoriaEquipoController {

    CategoriaEquipoService categoriaEquipoService
    def springSecurityService

    def index() {}

    def crear() {
        respond new CategoriaEquipo(params)
    }

    def save(CategoriaEquipo categoriaEquipo) {
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            if (categoriaEquipo.id != null) {
                categoriaEquipo.habilitado = params.habilitado == 'on'
            }
            categoriaEquipoService.save(categoriaEquipo, currentUser)
            redirect(controller: 'categoriaEquipo', action: 'index')
        } catch (ValidationException e) {
            println categoriaEquipo.errors
            respond categoriaEquipo.errors, view: 'crear'
        }
    }

    def verificarCategoriaDisponible() {
        render CategoriaEquipo.findByCategoria(params.data as String) ? true : false
    }

    def editar(long id) {
        [categoria: CategoriaEquipo.findById(id)]
    }
}
