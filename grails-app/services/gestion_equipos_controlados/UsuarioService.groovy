package gestion_equipos_controlados

import gestion_equipos_controlados.auth.Role
import gestion_equipos_controlados.auth.User
import gestion_equipos_controlados.auth.UserRole
import grails.gorm.transactions.Transactional

@Transactional
class UsuarioService {

    def save(User user, String[] roles){
        user.save(flush: true, failOnError: true)
        roles.each {
            UserRole.create(user, Role.findById(it as long), true)
        }
    }

    def update(User usuarioEditado, User usuarioGuardado, String[] roles){
        usuarioGuardado.username = usuarioEditado.username
        usuarioGuardado.name = usuarioEditado.name
        usuarioGuardado.email = usuarioEditado.email
        usuarioGuardado.enabled = usuarioEditado.enabled as boolean
        if (usuarioEditado.password) {
            usuarioGuardado.password = usuarioEditado.password
        }
        usuarioGuardado.save(flush: true, failOnError: true)

        //EDITANDO EL ROL DEL USUARIO
        def rolesActuales = usuarioGuardado.getAuthorities()
        def listaNuevosRoles = []
        roles.each { listaNuevosRoles.add(it as long) }

        rolesActuales.each {
            if (!listaNuevosRoles.contains(it.id)) {
                def userRole = UserRole.findByUserAndRole(usuarioGuardado, it)
                userRole.delete(flush: true)
            }
        }

        roles.each {
            if (!rolesActuales*.id.contains(it as long)) {
                UserRole.create(usuarioGuardado, Role.findById(it as long), true)
            }
        }
    }
}
