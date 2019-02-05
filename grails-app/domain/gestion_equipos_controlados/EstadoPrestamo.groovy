package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class EstadoPrestamo {

    final static int DEVUELTO = 1000
    final static int PRESTADO = 1001

    int codigo
    String estado
    User creadoPor
    User modificadoPor
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        creadoPor nullable: true
        modificadoPor nullable: true
    }
}
