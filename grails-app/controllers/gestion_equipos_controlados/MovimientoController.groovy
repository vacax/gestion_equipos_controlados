package gestion_equipos_controlados

class MovimientoController {

    def movimientoService

    def index() {
        def listadoMovimientos = Movimiento.findAll()

        [listadoMovimientos: listadoMovimientos]
    }

    def crearEntrada() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos : listadoEquipos]
    }

    def crearSalida() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos : listadoEquipos]
    }

    def guardarEntrada(Movimiento movimiento){
        try {
            movimiento.save(flush:true, failOnError:true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e){
            respond movimiento.errors, view: 'crearEntrada'
        }
    }

    def guardarSalida(Movimiento movimiento){
        try {
            movimiento.save(flush:true, failOnError:true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e){
            respond movimiento.errors, view: 'crearEntrada'
        }
    }
}
