package gestion_equipos_controlados

import gestion_equipos_controlados.auth.User

class EquipoSerial {

    Equipo equipo
    String serial
    EstadoEquipo estadoEquipo
    boolean generado = false
    boolean prestado = false
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
