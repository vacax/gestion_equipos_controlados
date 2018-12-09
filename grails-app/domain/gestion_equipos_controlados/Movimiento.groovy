package gestion_equipos_controlados

class Movimiento {

    enum TipoMovimiento {
        ENTRADA, SALIDA
    }

    int cantidad
    Equipo equipo
    TipoMovimiento tipoMovimiento
    boolean habilitado

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
