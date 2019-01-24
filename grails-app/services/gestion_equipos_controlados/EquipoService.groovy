package gestion_equipos_controlados

import grails.gorm.transactions.Transactional

@Transactional
class EquipoService {

    def save(Equipo equipo){
        equipo.save(flush: true, failOnError: true)
    }

    def update(long idEquipo, String nombre, long categoriaEquipo){
        def equipoTmp = Equipo.findById(idEquipo)
        def categoriaTmp = CategoriaEquipo.findById(categoriaEquipo)
        equipoTmp.nombre = nombre
        equipoTmp.categoriaEquipo = categoriaTmp

        equipoTmp.save(flush: true, failsOnError: true)

    }
}
