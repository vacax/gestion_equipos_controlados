package gestion_equipos_controlados

import grails.gorm.transactions.Transactional

@Transactional
class CategoriaEquipoService {

    def save(categoriaEquipo) {
        categoriaEquipo.save(flush: true, failOnError: true)
    }

    def serviceMethod() {

    }
}
