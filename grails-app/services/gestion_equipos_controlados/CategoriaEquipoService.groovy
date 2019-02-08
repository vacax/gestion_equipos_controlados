package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.gorm.transactions.Transactional

@Transactional
class CategoriaEquipoService {

    def save(CategoriaEquipo categoriaEquipo, User user) {
        if (!categoriaEquipo.id){
            categoriaEquipo.creadoPor = user
        }
        categoriaEquipo.modificadoPor = user
        categoriaEquipo.save(flush: true, failOnError: true)
    }
}
