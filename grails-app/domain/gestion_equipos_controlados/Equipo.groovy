package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class Equipo {

    String nombre
    long cantidadTotal = 0
    long cantidadDisponible = 0
    CategoriaEquipo categoriaEquipo
    boolean serial = false
    User creadoPor
    User modificadoPor
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        nombre unique: true
        creadoPor nullable: true
        modificadoPor nullable: true
    }
}
