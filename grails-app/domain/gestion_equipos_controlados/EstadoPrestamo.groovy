package gestion_equipos_controlados

class EstadoPrestamo {

    final static int COMPLETADO = 1000
    final static int PENDIENTE = 1001

    int codigo
    String estado
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
