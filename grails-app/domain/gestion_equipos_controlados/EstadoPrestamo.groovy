package gestion_equipos_controlados

class EstadoPrestamo {

    final static int DEVUELTO = 1000
    final static int PRESTADO = 1001

    int codigo
    String estado
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
