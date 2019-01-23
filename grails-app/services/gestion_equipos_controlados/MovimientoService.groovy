package gestion_equipos_controlados

import grails.gorm.transactions.Transactional

@Transactional
class MovimientoService {

    def guardarEntrada(long equipoId, int cantidad, def serial) {
        def equipo = Equipo.findById(equipoId as long)
        def movimiento = new Movimiento()
        def estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.BUENO)

        if (equipo != null) {
            movimiento.equipo = equipo
            movimiento.cantidad = cantidad
            movimiento.tipoMovimiento = Movimiento.TipoMovimiento.ENTRADA

            cantidad.times {
                if (serial != '') {
                    new EquipoSerial(equipo: equipo, serial: serial, estadoEquipo: estadoEquipo).save(flush: true, failOnError: true)
                } else {
                    def serialGenerado = "GECP-" + equipo.nombre.toUpperCase().take(4) + "-" + EquipoSerial.last().id
                    new EquipoSerial(equipo: equipo, serial: serialGenerado, generado: true, estadoEquipo: estadoEquipo).save(flush: true, failOnError: true)
                }
            }

            equipo.cantidadDisponible += cantidad
            equipo.cantidadTotal += cantidad
            equipo.save(flush: true, failOnError: true)
            movimiento.save(flush: true, failOnError: true)
            return movimiento
        }
    }

    def guardarSalida(long equipoSerialId) {
        def equipoSerial = EquipoSerial.findById(equipoSerialId)
        def equipo = Equipo.findById(equipoSerial.equipo.id)

        def movimiento = new Movimiento()
        movimiento.equipo = equipo
        movimiento.cantidad = 1
        movimiento.tipoMovimiento = Movimiento.TipoMovimiento.SALIDA

        equipo.cantidadTotal -= 1
        equipo.cantidadDisponible -= 1

        equipoSerial.habilitado = false

        equipoSerial.save(flush: true, failOnError: true)
        equipo.save(flush: true, failOnError: true)

        return movimiento
    }
}
