package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class CategoriaEquipo {

    String categoria
    User creadoPor
    User modificadoPor
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated


    static constraints = {
        categoria unique: true
        creadoPor nullable: true
        modificadoPor nullable: true
    }
}
