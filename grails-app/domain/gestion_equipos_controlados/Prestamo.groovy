package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class Prestamo {

    String nombreEstudiante
    String matriculaEstudiante
    Date fechaSolicitud = new Date()
    Date fechaEntrega = new Date()
    String observacion = " "
    EstadoPrestamo estadoPrestamo
    Prestamo prestamoRenovado
    User creadoPor
    User modificadoPor
    boolean habilitado = true

    static hasMany = [listaPrestamoDetalle: PrestamoDetalle]

    Date dateCreated
    Date lastUpdated

    static constraints = {
        prestamoRenovado nullable: true
        observacion maxSize: 1000
        creadoPor nullable: true
        modificadoPor nullable: true
    }

    static prestamosVenciendo() {
        def prestamos = findAllByEstadoPrestamoNotEqual(EstadoPrestamo.findByCodigo(EstadoPrestamo.DEVUELTO))
        def prestamosVen = []
        prestamos.each {
            if (it.fechaEntrega >= new Date() - 7)
                prestamosVen.add(it)
        }
        return prestamosVen
    }

    static prestamosVencidos(){
        def prestamos = findAllByHabilitadoAndEstadoPrestamo(true, EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))
        def prestamosVen = []
        def fechaActual = new Date()
        prestamos.each {
            if (it.fechaEntrega < fechaActual)
                prestamosVen.add(it)
        }
        return prestamosVen.take(5)
    }

    static prestamosVencidosAll(){
        def prestamos = findAllByHabilitadoAndEstadoPrestamo(true, EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))
        def prestamosVen = []
        def fechaActual = new Date()
        prestamos.each {
            if (it.fechaEntrega < fechaActual)
                prestamosVen.add(it)
        }
        return prestamosVen
    }

    static prestamosActivos(){
        def estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO)
        def prestamos = findAllByHabilitadoAndEstadoPrestamo(true, estadoPrestamo)
        return prestamos
    }
}
