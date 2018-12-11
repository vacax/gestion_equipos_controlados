package gestion_equipos_controlados

class MovimientoController {

    def movimientoService

    def index() {
        def listadoMovimientos = Movimiento.findAll()

        [listadoMovimientos: listadoMovimientos]
    }

    def crearEntrada() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos: listadoEquipos]
    }

    def crearSalida() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos: listadoEquipos]
    }

    def guardarEntrada() {
        def equipo = Equipo.findById(params.equipo as long)
        def movimiento = new Movimiento()

        if(equipo != null){
            movimiento.equipo = equipo
            movimiento.cantidad = params.cantidad as int
            movimiento.tipoMovimiento = Movimiento.TipoMovimiento.ENTRADA
            if(params.serial != null){
                params.serial.each {
                    new EquipoSerial(equipo: equipo, serial: it).save(flush:true, failOnError: true)
                }
            }
        }

        try {
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearEntrada'
        }
    }

    def guardarSalida(Movimiento movimiento) {
        try {
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearEntrada'
        }
    }

    def verificarNecesitaSerial() {
        def equipo = Equipo.findById(params.data as long)
        if (equipo != null)
            render equipo.serial
        else
            render 'null'
    }
}
