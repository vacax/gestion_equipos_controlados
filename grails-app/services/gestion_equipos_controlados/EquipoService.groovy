package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.gorm.transactions.Transactional

@Transactional
class EquipoService {

    def save(Equipo equipo, User currentUser){
        equipo.creadoPor = currentUser
        equipo.modificadoPor = currentUser
        equipo.save(flush: true, failOnError: true)
    }

    def update(long idEquipo, String nombre, long categoriaEquipo, boolean habilitado, User user){
        def equipoTmp = Equipo.findById(idEquipo)
        def categoriaTmp = CategoriaEquipo.findById(categoriaEquipo)
        equipoTmp.nombre = nombre
        equipoTmp.categoriaEquipo = categoriaTmp
        equipoTmp.habilitado = habilitado
        equipoTmp.modificadoPor = user
        equipoTmp.save(flush: true, failsOnError: true)

    }
}
