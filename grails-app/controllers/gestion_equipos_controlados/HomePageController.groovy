package gestion_equipos_controlados


import org.springframework.security.access.annotation.Secured


@Secured(['ROLE_ADMIN'])
class HomePageController {

    def index() {
        def prueba = Equipo.executeQuery('from Equipo where habilitado = true order by rand()', [max: 5])
        def prestamosVencidos = Prestamo.prestamosVencidos()
        [listadoEquipos: prueba, prestamosVencidos : prestamosVencidos]
    }
}
