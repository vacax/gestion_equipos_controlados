package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_USUARIO'])
class UsuarioController {

    UsuarioService usuarioService

    def index() {}

    def crear() {
        respond new User(params)
    }

    def save(User user) {
        try {
            usuarioService.save(user, params.roles as String[])
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
            usuarioService.update(user, storedUser, params.roles as String[])
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
