package gestion_equipos_controlados

import gestion_equipos_controlados.auth.Role
import gestion_equipos_controlados.auth.User
import gestion_equipos_controlados.auth.UserRole

class BootStrap {

    def init = { servletContext ->

        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 1')
        CategoriaEquipo.findOrSaveWhere(categoria: 'Categoria 2')

        Equipo.findOrSaveWhere(nombre: 'Equipo 1', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first(), serial: true)
        Equipo.findOrSaveWhere(nombre: 'Equipo 2', cantidadDisponible: 10l, cantidadTotal: 10l, categoriaEquipo: CategoriaEquipo.first())

        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.DEVUELTO, estado: "DEVUELTO")
        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.PRESTADO, estado: "PRESTADO")

        def user = User.findOrSaveWhere(username: 'admin', password: 'admin', email: 'admin@admin.com')
        def role = Role.findOrSaveWhere(authority: 'ROLE_ADMIN')

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

        Prestamo.findOrSaveWhere(nombreEstudiante: "Stanley De Moya", matriculaStudiante: "2012-0412", fechaSolicitud: new Date(), fechaEntrega: new Date(), estadoPrestamo: EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("6789-SDFEA"))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO2"))
        PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO1"))
    }
    def destroy = {
    }
}
