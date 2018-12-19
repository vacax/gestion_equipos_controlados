package gestion_equipos_controlados

class BootStrap {

    def init = { servletContext ->

        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 1')
        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 2')

        Equipo.findOrSaveWhere(nombre: 'Equipo 1', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first(), serial: true)
        Equipo.findOrSaveWhere(nombre: 'Equipo 2', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())

        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.DEVUELTO, estado: "DEVUELTO")
        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.PRESTADO, estado: "PRESTADO")

    }
    def destroy = {
    }
}
