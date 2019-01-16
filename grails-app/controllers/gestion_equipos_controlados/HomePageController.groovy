package gestion_equipos_controlados

import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_ADMIN'])
class HomePageController {

    def index() {

    }
}
