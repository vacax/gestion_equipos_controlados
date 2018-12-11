package gestion_equipos_controlados

class EquipoSerial {

    Equipo equipo
    String serial
    boolean prestado
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
