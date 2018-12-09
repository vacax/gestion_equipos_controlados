package gestion_equipos_controlados

class Prestamo {

    String nombreEstudiante
    String matriculaStudiante
    Date fechaSolicitud
    Date fechaEntrega
    EstadoPrestamo estadoPrestamo
    Prestamo prestamoRenovado
    boolean habilitado

    static hasMany = [listaPrestamoDetalle: PrestamoDetalle]

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
