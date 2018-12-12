package gestion_equipos_controlados

import grails.validation.ValidationException

class CategoriaEquipoController {

    def index() {}

    def crear() {
        respond new CategoriaEquipo(params)
    }

    def save(CategoriaEquipo categoriaEquipo) {
        try {
            categoriaEquipo.habilitado = params.habilitado == 'on'
            categoriaEquipo.save(flush: true, failOnError: true)
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
