package gestion_equipos_controlados

class Equipo {

    String nombre
    long cantidadTotal
    long cantidadDisponible
    CategoriaEquipo categoriaEquipo
    boolean serial = false
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        nombre unique: true
    }
}
