package gestion_equipos_controlados

import gestion_equipos_controlados.auth.Role
import gestion_equipos_controlados.auth.User
import gestion_equipos_controlados.auth.UserRole
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->

        def ambiente = Environment.current
        if(ambiente == Environment.DEVELOPMENT){
          //TODO: completar
        }

        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 1')
        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 2')

        Equipo.findOrSaveWhere(nombre: 'Equipo 1', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first(), serial: true)
        Equipo.findOrSaveWhere(nombre: 'Equipo 2', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 3', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 4', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 5', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 6', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 7', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())
        Equipo.findOrSaveWhere(nombre: 'Equipo 8', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())

        //TODO: parte de la aplicación.
        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.DEVUELTO, estado: "DEVUELTO")
        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.PRESTADO, estado: "PRESTADO")

        def user = User.findOrSaveWhere(username: 'admin', name: 'Admin', password: 'admin', email: 'admin@admin.com')
        def role = Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        def role2 = Role.findOrSaveWhere(authority: 'ROLE_STAFF')

        UserRole.findOrSaveWhere(user: user, role: role)

        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.BUENO, estado: "BUENO")
        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.PERDIDO, estado: "PERDIDO")
        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.DANADO, estado: "DAÑADO")

        //pruebas para hacer un prestamo

        EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 1"), serial: "12345-sdfea", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO))
        EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 1"), serial: "6789-SDFEA", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO))
        EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO1", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)
        EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO2", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)
        EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO3", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)

        Prestamo.findOrSaveWhere(nombreEstudiante: "Stanley De Moya", matriculaEstudiante: "2012-0412", fechaSolicitud: new Date(), fechaEntrega: new Date(2019, 1, 12), estadoPrestamo: EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("6789-SDFEA"), usuarioEntrega: User.findById(1))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO2"), usuarioEntrega: User.findById(1))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO1"), usuarioEntrega: User.findById(1))
    }
    def destroy = {
    }
}
