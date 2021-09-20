package gestion_equipos_controlados

import gestion_equipos_controlados.auth.Role
import gestion_equipos_controlados.auth.User
import gestion_equipos_controlados.auth.UserRole
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->

        def ambiente = Environment.current


        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.DEVUELTO, estado: "DEVUELTO")
        EstadoPrestamo.findOrSaveWhere(codigo: EstadoPrestamo.PRESTADO, estado: "PRESTADO")

        //Comportamiento extraño, cambiando a la forma tradicional
        def user = User.findByUsername("admin")? User.findByUsername("admin") : new User(username: 'admin', name: 'Admin', password: 'admin', email: 'admin@admin.com').save(failover: true)
        def role = Role.findOrSaveWhere(authority: 'ROLE_ADMIN')

        Role.findOrSaveWhere(authority: 'ROLE_GESTIONAR_EQUIPO')
        Role.findOrSaveWhere(authority: 'ROLE_GESTIONAR_CATEGORIA_EQUIPO')
        Role.findOrSaveWhere(authority: 'ROLE_GESTIONAR_MOVIMIENTO')
        Role.findOrSaveWhere(authority: 'ROLE_GESTIONAR_USUARIO')
        Role.findOrSaveWhere(authority: 'ROLE_GESTIONAR_PRESTAMO')

        /*def userRole = UserRole.findByUserAndRole(user, role);
        println "El usuario role: "+userRole?.properties
        UserRole.findByUserAndRole(user, role) == null ? null : new UserRole(user: user, role: role).save(failover: true)*/
        //UserRole.findOrSaveWhere(user: user, role: role)
        //Comportamiento extraño, cambiando a la versión tradicional
        UserRole.get(user.id, role.id) ? null : new UserRole(user: user, role: role).save(failover: true)

        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.BUENO, estado: "BUENO")
        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.PERDIDO, estado: "PERDIDO")
        EstadoEquipo.findOrSaveWhere(codigo: EstadoEquipo.DANADO, estado: "DAÑADO")

        CategoriaEquipo.findOrSaveWhere(categoria: 'Smartphone')
        CategoriaEquipo.findOrSaveWhere(categoria: 'Sensor')

        println("Aplicación en modo ${ambiente}")
        if(ambiente == Environment.DEVELOPMENT){

            println("Aplicación en modo desarrollo")

            Equipo.findOrSaveWhere(nombre: 'Equipo 1', categoriaEquipo: CategoriaEquipo.first(), serial: true)
            Equipo.findOrSaveWhere(nombre: 'Equipo 2', categoriaEquipo: CategoriaEquipo.first())
            Equipo.findOrSaveWhere(nombre: 'Equipo 3', categoriaEquipo: CategoriaEquipo.first(), serial: true)
            Equipo.findOrSaveWhere(nombre: 'Equipo 4', categoriaEquipo: CategoriaEquipo.first())

            //pruebas para hacer un prestamo
            Movimiento.findOrSaveWhere(tipoMovimiento: Movimiento.TipoMovimiento.ENTRADA, equipo: Equipo.findByNombre("Equipo 2"), cantidad: 3, creadoPor: user)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO1", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO2", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 2"), serial: "GENERADO3", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)

            Movimiento.findOrSaveWhere(tipoMovimiento: Movimiento.TipoMovimiento.ENTRADA, equipo: Equipo.findByNombre("Equipo 1"), cantidad: 2, creadoPor: user)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 1"), serial: "12345", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO))
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 1"), serial: "6789", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO))

            Movimiento.findOrSaveWhere(tipoMovimiento: Movimiento.TipoMovimiento.ENTRADA, equipo: Equipo.findByNombre("Equipo 3"), cantidad: 1, creadoPor: user)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 3"), serial: "54321", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO))

            Movimiento.findOrSaveWhere(tipoMovimiento: Movimiento.TipoMovimiento.ENTRADA, equipo: Equipo.findByNombre("Equipo 4"), cantidad: 100, creadoPor: user)
            EquipoSerial.findOrSaveWhere(equipo: Equipo.findByNombre("Equipo 4"), serial: "GENERADO4", estadoEquipo: EstadoEquipo.findByCodigo(EstadoEquipo.BUENO), generado: true)


            Prestamo.findOrSaveWhere(nombreEstudiante: "Stanley De Moya", matriculaEstudiante: "2012-0412", fechaSolicitud: new Date(), fechaEntrega: new Date(2019, 1, 12), estadoPrestamo: EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))
            PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("6789"), usuarioEntrega: User.findById(1))
            PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO2"), usuarioEntrega: User.findById(1))
            PrestamoDetalle.findOrSaveWhere(prestamo: Prestamo.findByNombreEstudiante("Stanley De Moya"), cantidadPrestado: 1, equipoSerial: EquipoSerial.findBySerial("GENERADO1"), usuarioEntrega: User.findById(1))

            /*def equipo1 = Equipo.findByNombre("Equipo 1")
            equipo1.cantidadDisponible = 1l
            equipo1.save(flush: true, failOnError: true)

            def equipo2 = Equipo.findByNombre("Equipo 2")
            equipo2.cantidadDisponible = 1l
            equipo2.save(flush: true, failOnError: true)

            def equipo3 = Equipo.findByNombre("Equipo 3")
            equipo3.cantidadDisponible = 1l
            equipo3.save(flush: true, failOnError: true)

            def equipo4 = Equipo.findByNombre("Equipo 2")
            equipo4.cantidadDisponible = 1l
            equipo4.save(flush: true, failOnError: true)*/

        }

    }
    def destroy = {
    }
}
