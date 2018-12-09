package gestion_equipos_controlados

import grails.validation.ValidationException

class CategoriaEquipoController {

    def index() { }

    def crear(){
        respond new CategoriaEquipo(params)
    }

    def save(CategoriaEquipo categoriaEquipo){
        try {
            categoriaEquipo.save(flush: true, failOnError: true)
            redirect(controller: 'categoriaEquipo', action: 'index')
        } catch (ValidationException e) {
            respond categoriaEquipo.errors, view: 'crear'
        }
    }

    def verificarCategoriaDisponible(){
        render CategoriaEquipo.findByCategoria(params.data as String) ? true : false
    }
}
