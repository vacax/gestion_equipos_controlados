package gestion_equipos_controlados


import org.springframework.security.access.annotation.Secured


@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_EQUIPO', 'ROLE_GESTIONAR_CATEGORIA_EQUIPO',
        'ROLE_GESTIONAR_MOVIMIENTO', 'ROLE_GESTIONAR_USUARIO', 'ROLE_GESTIONAR_PRESTAMO'])
class HomePageController {

    def index() {
        def prueba = Equipo.executeQuery('from Equipo where habilitado = true order by rand()', [max: 5])
        def prestamosVencidos = Prestamo.prestamosVencidos()
        [listadoEquipos: prueba, prestamosVencidos: prestamosVencidos]
    }
}
