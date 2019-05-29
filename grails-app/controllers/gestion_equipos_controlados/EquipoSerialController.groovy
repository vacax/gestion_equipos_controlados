package gestion_equipos_controlados

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
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

    def agregarEquipoNoSerial(long equipoId, long cantidadEquipo) {
        println("Consultando equipoId: $equipoId - Cantidad: $cantidadEquipo")
        def resp = [:]
        def ok = false
        try {
            def eq = Equipo.findById(equipoId)
            if (eq && (eq.cantidadDisponible >= cantidadEquipo)) {
                resp['equipoSerial'] = 'N/A'
                resp['equipo'] = eq
                resp['cantidad'] = params.cantidadEquipo as long
                ok = true
            }
        } catch (Exception e) {
            println e.message
            ok = false
        }
        resp['ok'] = ok
        println("Respuesta validación Equipo No Serial: "+resp)
        render resp as JSON
    }
}
