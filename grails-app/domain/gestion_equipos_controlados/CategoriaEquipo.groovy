package gestion_equipos_controlados

class CategoriaEquipo {

    String categoria
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated


    static constraints = {
        categoria unique: true
    }
}
