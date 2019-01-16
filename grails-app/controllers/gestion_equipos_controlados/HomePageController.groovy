package gestion_equipos_controlados

class HomePageController {

    def index() {
        def listadoMovimientos = Movimiento.findAllByHabilitado(true)
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoMovimientos: listadoMovimientos, listadoEquipos: listadoEquipos]
    }
}
