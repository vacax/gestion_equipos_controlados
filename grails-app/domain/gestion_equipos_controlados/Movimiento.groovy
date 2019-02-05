package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class Movimiento {

    enum TipoMovimiento {
        ENTRADA, SALIDA
    }

    int cantidad
    Equipo equipo
    TipoMovimiento tipoMovimiento
    String comentario
    User creadoPor
    User modificadoPor
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        comentario nullable: true
        creadoPor nullable: true
        modificadoPor nullable: true
    }
}
