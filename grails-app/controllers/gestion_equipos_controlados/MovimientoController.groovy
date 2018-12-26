package gestion_equipos_controlados

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class MovimientoController {

    def index() {
        def listadoMovimientos = Movimiento.findAllByHabilitado(true)
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoMovimientos: listadoMovimientos, listadoEquipos: listadoEquipos]
    }

    def crearEntrada() {
        def listadoEquipos = Equipo.findAllByHabilitado(true)
        [listadoEquipos: listadoEquipos]
    }

    def crearSalida() {
        def listadoEquipos = EquipoSerial.findAllByHabilitadoAndPrestado(true, false)
        [listadoEquipos: listadoEquipos]
    }

    def guardarEntrada() {
        def equipo = Equipo.findById(params.equipo as long)
        def movimiento = new Movimiento()
        def estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.BUENO)

        if (equipo != null) {
            def cantidad = params.cantidad as int
            movimiento.equipo = equipo
            movimiento.cantidad = cantidad
            movimiento.tipoMovimiento = Movimiento.TipoMovimiento.ENTRADA
            /*if (equipo.serial && params.serial != null) {
                params.serial.each {
                    new EquipoSerial(equipo: equipo, serial: it).save(flush: true, failOnError: true)
                }
            }*/
          
            cantidad.times{
                if (params.serial != ''){
                    new EquipoSerial(equipo: equipo, serial: params.serial, estadoEquipo: estadoEquipo).save(flush: true, failOnError: true)
                }
                else {
                    def serialGenerado = "GECP-"+ equipo.nombre.toUpperCase().take(4) + "-" + EquipoSerial.last().id
                    new EquipoSerial(equipo: equipo, serial: serialGenerado, generado: true, estadoEquipo: estadoEquipo).save(flush: true, failOnError: true)
                }
            }

            equipo.cantidadDisponible += cantidad
            equipo.cantidadTotal += cantidad
            equipo.save(flush: true, failOnError: true)
        }

        try {
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearEntrada'
        }
    }

    def guardarSalida() {
        def movimiento = new Movimiento()
        def equipoSerial = EquipoSerial.findById(params.data as long)
        def equipo = Equipo.findById(equipoSerial.equipo.id)

        movimiento.equipo = equipo
        movimiento.cantidad = 1
        movimiento.tipoMovimiento = Movimiento.TipoMovimiento.SALIDA

        equipo.cantidadTotal -= 1
        equipo.cantidadDisponible -= 1

        equipoSerial.habilitado = false

        try {
            equipoSerial.save(flush: true, failOnError: true)
            equipo.save(flush: true, failOnError: true)
            movimiento.save(flush: true, failOnError: true)
            redirect(controller: 'movimiento', action: 'index')
        }
        catch (Exception e) {
            respond movimiento.errors, view: 'crearSalida'
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
