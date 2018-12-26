package gestion_equipos_controlados

class PrestamoDetalle {

    Prestamo prestamo
    int cantidadPrestado
    EquipoSerial equipoSerial
    boolean entregado = false
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {}
}
