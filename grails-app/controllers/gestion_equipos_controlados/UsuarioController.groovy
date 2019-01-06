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
            UserRole.create(user, Role.findById(params.role as long), true)
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

    def update(User user){

        try {
            def storedUser = User.findByUsername(params.old_username as String)
            storedUser.username = user.username
            storedUser.name = user.name
            storedUser.email = user.email
            storedUser.enabled = params.enabled as boolean
            if (user.password){
                storedUser.password = user.password
            }
            storedUser.save(flush: true, failOnError: true)
            redirect(controller: 'usuario', action: 'index')
        } catch (Exception e) {
            println(e.message)
            println(user.errors)
            respond user.errors, view: 'editar'
        }
    }

    def verificarUsernameDisponible() {
        def ok
        def user = User.findByUsername(params.data as String)
        if (user != null) {
            ok = !user.username == params.data
        } else {
            ok = false
        }
        render ok
    }
}
