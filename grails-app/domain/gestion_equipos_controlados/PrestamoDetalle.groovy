package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class PrestamoDetalle {

    Prestamo prestamo
    int cantidadPrestado
    EquipoSerial equipoSerial
    User usuarioEntrega
    User usuarioRecibo
    boolean entregado = false
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
        usuarioRecibo nullable: true

    }
}
