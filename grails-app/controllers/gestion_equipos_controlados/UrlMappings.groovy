package gestion_equipos_controlados

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }


        "/"(controller:"homePage", action:"index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
