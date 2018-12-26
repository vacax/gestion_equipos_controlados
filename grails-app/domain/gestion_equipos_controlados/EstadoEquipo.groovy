package gestion_equipos_controlados

class EstadoEquipo {

    final static int BUENO = 1000
    final static int DANADO = 1001
    final static int PERDIDO = 1002

    int codigo
    String estado
    boolean habilitado = true

    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
