package gestion_equipos_controlados

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class EquipoSerialController {

    def index() {}

    def buscarEquipoSerial() {
        def resp = [:]
        def ok = false
        try {
            def es = EquipoSerial.findBySerial(params.data as String)
            if (es && !es.prestado) {
                resp['equipoSerial'] = es
                resp['equipo'] = es.equipo
                resp['cantidad'] = 1
                ok = true
            }
        } catch (Exception e) {
            println e.message
            ok = false
        }
        resp['ok'] = ok
        render resp as JSON
    }

    def agregarEquipoNoSerial() {
        def resp = [:]
        def ok = false
        try {
            def es = EquipoSerial.findBySerial(params.data as String)
            if (es && es.equipo.cantidadDisponible > 0) {
                resp['equipoSerial'] = es
                resp['equipo'] = es.equipo
                resp['cantidad'] = params.cantidadEquipo as long
                ok = true
            }
        } catch (Exception e) {
            ok = false
        }
        resp['ok'] = ok
        render resp as JSON
    }
}
