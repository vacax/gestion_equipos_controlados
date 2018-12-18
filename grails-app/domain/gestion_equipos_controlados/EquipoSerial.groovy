package gestion_equipos_controlados

class EquipoSerial {

    Equipo equipo
    String serial
    boolean generado = false
    boolean prestado = false
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
