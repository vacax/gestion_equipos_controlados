package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class UsuarioController {

    def index() { }

    def crear(){
        respond new User(params)
    }

    def save(User user){
        try {
            user.save(flush: true, failOnError: true)
            redirect(controller: 'usuario', action: 'index')
        } catch (Exception e){
            println(e.message)
            println(user.errors)
            respond user.errors, view: 'crear'
        }
    }

    def verificarUsernameDisponible() {
        render User.findByUsername(params.data as String) ? true : false
    }
}
