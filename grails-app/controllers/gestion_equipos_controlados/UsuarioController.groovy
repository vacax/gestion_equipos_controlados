package gestion_equipos_controlados

import gestion_equipos_controlados.auth.Role
import gestion_equipos_controlados.auth.User
import gestion_equipos_controlados.auth.UserRole
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class UsuarioController {

    def index() {}

    def crear() {
        respond new User(params)
    }

    def save(User user) {
        try {
            user.save(flush: true, failOnError: true)
            params.roles.each {
                UserRole.create(user, Role.findById(it as long), true)
            }
            redirect(controller: 'usuario', action: 'index')
        } catch (Exception e) {
            println(e.message)
            println(user.errors)
            respond user.errors, view: 'crear'
        }
    }

    def editar(long id) {
        def user = User.findById(id)
        ['user': user]
    }

    def update(User user) {

        try {
            def storedUser = User.findByUsername(params.old_username as String)
            storedUser.username = user.username
            storedUser.name = user.name
            storedUser.email = user.email
            storedUser.enabled = params.enabled as boolean
            if (user.password) {
                storedUser.password = user.password
            }
            storedUser.save(flush: true, failOnError: true)

            //EDITANDO EL ROL DEL USUARIO
            def rolesActuales = storedUser.getAuthorities()
            def listaNuevosRoles = []
            params.roles.each { listaNuevosRoles.add(it as long) }

            rolesActuales.each {
                if (!listaNuevosRoles.contains(it.id)) {
                    def userRole = UserRole.findByUserAndRole(storedUser, it)
                    userRole.delete(flush: true)
                }
            }

            params.roles.each {
                if (!rolesActuales*.id.contains(it as long)) {
                    UserRole.create(storedUser, Role.findById(it as long), true)
                }
            }

            redirect(controller: 'usuario', action: 'index')
        } catch (Exception e) {
            println(e.message)
            println(user.errors)
            respond user.errors, view: 'editar'
        }
    }

    def verificarUsernameDisponible() {
        render User.findByUsername(params.data as String) == null
    }

    def verificarUsernameEditadoDisponible() {
        def ok = false
        def user = User.findById(params.id as long)
        if (user != null) {
            if (user.username == params.newUsername)
                ok = true
            else
                ok = User.findByUsername(params.newUsername as String) == null
        }
        render ok
    }
}
