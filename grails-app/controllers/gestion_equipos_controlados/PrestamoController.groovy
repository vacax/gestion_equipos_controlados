package gestion_equipos_controlados

class PrestamoController {

    def index() { }

    def recibir(){
        def prestamo = Prestamo.findByNombreEstudiante("Stanley De Moya")
        /*
        prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PENDIENTE)
        prestamo.listaPrestamoDetalle.each {
            it.entregado = false
            it.save(flush:true, failOnError:true)
        }
        prestamo.save(flush:true, failOnError:true)
        */
        [prestamo : prestamo]
    }

    def recibirTodo(long prestamo){

        def prestamoTmp = Prestamo.findById(prestamo)
        prestamoTmp.listaPrestamoDetalle.each {
            it.entregado = true
            it.equipoSerial.prestado = false
            it.save(flush: true, failOnError: true)
        }
        prestamoTmp.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
        prestamoTmp.save(flush:true, failOnError:true)
        // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
        redirect(controller: 'prestamo', action: 'recibir')
    }

    def recibirParcial(long prestamoDetalle){


            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
            def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
            equipoSerialTmp.prestado = false
            prestamoDetalleTmp.entregado = true
            equipoSerialTmp.save(flush: true, failOnError: true)
            prestamoDetalleTmp.save(flush: true, failOnError: true)

            def prestamoCompleto = prestamo.listaPrestamoDetalle.every{ it.entregado }
            if(prestamoCompleto){
                prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
                prestamo.save(flush: true, failOnError: true)
            }
            // redirect(uri: "prestamo/recibir?prestamo=" + prestamo.id)
            redirect(controller: 'prestamo', action: 'recibir')

    }

    def recibirParcialProblema(long prestamoDetalle){

        try{
            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            def equipoSerialTmp = EquipoSerial.findById(prestamoDetalleTmp.equipoSerial.id)
            def equipo = Equipo.findById(equipoSerialTmp.equipo.id)
            def prestamo = Prestamo.findById(prestamoDetalleTmp.prestamo.id)
            def salidaEquipo = new Movimiento()

            equipoSerialTmp.prestado = false
            equipoSerialTmp.estadoEquipo = EstadoEquipo.findByCodigo(EstadoEquipo.DANADO)
            prestamoDetalleTmp.entregado = true
            equipoSerialTmp.save(flush: true, failOnError: true)
            prestamoDetalleTmp.save(flush: true, failOnError: true)

            salidaEquipo.equipo = equipo
            salidaEquipo.cantidad = 1
            salidaEquipo.tipoMovimiento = Movimiento.TipoMovimiento.SALIDA
            salidaEquipo.save(flush: true, failOnError: true)

            equipo.cantidadTotal -= 1
            equipo.cantidadDisponible -= 1
            equipo.save(flush: true, failOnError:true)

            def prestamoCompleto = prestamo.listaPrestamoDetalle.every{it.entregado}
            if(prestamoCompleto){
                prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO)
                prestamo.save(flush: true, failOnError: true)
            }

            redirect(controller: 'prestamo', action: 'recibir')
        }
        catch (Exception e){

        }
    }
}
