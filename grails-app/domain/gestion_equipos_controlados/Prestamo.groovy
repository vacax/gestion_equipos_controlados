package gestion_equipos_controlados

class Prestamo {

    String nombreEstudiante
    String matriculaStudiante
    Date fechaSolicitud = new Date()
    Date fechaEntrega =  new Date()
    EstadoPrestamo estadoPrestamo
    Prestamo prestamoRenovado
    boolean habilitado = true

    static hasMany = [listaPrestamoDetalle: PrestamoDetalle]

    Date dateCreated
    Date lastUpdated

    static constraints = {
        prestamoRenovado nullable: true
    }
}
