package gestion_equipos_controlados

class PrestamoDetalle {

    Prestamo prestamo
    Equipo equipo
    int cantidadPendienteEntrega
    int cantidadPrestado
    EquipoSerial equipoSerial
    boolean entregado
    boolean habilitado

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
