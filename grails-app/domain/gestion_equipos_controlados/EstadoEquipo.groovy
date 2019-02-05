package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class EstadoEquipo {

    final static int BUENO = 1000
    final static int DANADO = 1001
    final static int PERDIDO = 1002

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
