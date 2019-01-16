package gestion_equipos_controlados

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/homePage/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
