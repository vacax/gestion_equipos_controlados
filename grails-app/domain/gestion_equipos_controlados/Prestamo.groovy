package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class Prestamo {

    String nombreEstudiante
    String matriculaEstudiante
    Date fechaSolicitud = new Date()
    Date fechaEntrega = new Date()

    EstadoPrestamo estadoPrestamo
    Prestamo prestamoRenovado
    boolean habilitado = true

    static hasMany = [listaPrestamoDetalle: PrestamoDetalle]

    Date dateCreated
    Date lastUpdated

    static constraints = {
        prestamoRenovado nullable: true
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
}
