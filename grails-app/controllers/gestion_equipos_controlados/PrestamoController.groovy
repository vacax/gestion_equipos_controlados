package gestion_equipos_controlados

import edu.pucmm.eict.util.Utilidades
import gestion_equipos_controlados.auth.User
import grails.converters.JSON
import org.springframework.security.access.annotation.Secured


@Secured(['ROLE_ADMIN', 'ROLE_GESTIONAR_PRESTAMO'])
class PrestamoController {

    def springSecurityService
    def reportesService
    def prestamoService

    def index() {
        ['prestamos': Prestamo.findAllByEstadoPrestamo(EstadoPrestamo.findByCodigo(EstadoPrestamo.PRESTADO))]
    }

    def crear() {
        respond new Prestamo(params)
    }

    def save() {
        def ok
        try {
            def dataEstudiante = JSON.parse(params.estudiante)
            def dataPrestamo = JSON.parse(params.dataPrestamo)
            def currentUser = (User) springSecurityService.getCurrentUser()
            prestamoService.save(dataEstudiante, dataPrestamo, currentUser)
            ok = true
        } catch (Exception e) {
            println e.message
            ok = false
        }

        render ok
    }

    def historial() {
        ['prestamos': Prestamo.findAll()]
    }

    def recibir(long id) {
        def prestamoTmp = Prestamo.findById(id)
        /*
        prestamo.estadoPrestamo = EstadoPrestamo.findByCodigo(EstadoPrestamo.PENDIENTE)
        prestamo.listaPrestamoDetalle.each {
            it.entregado = false
            it.save(flush:true, failOnError:true)
        }
        prestamo.save(flush:true, failOnError:true)
        */
        [prestamo: prestamoTmp]
    }

    def recibirTodo(long prestamo) {
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            prestamoService.recibirTodo(prestamo, currentUser)
        } catch (Exception e) {
            println e.message
        }
        redirect(controller: 'prestamo', action: 'recibir', params: [id: prestamo])
    }

    def recibirParcial(long id) {
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            def prestamoDetalleTmp = PrestamoDetalle.findById(id)
            prestamoService.recibirParcial(prestamoDetalleTmp, currentUser)
            redirect(controller: 'prestamo', action: 'recibir', params: [id: prestamoDetalleTmp.prestamo.id])
        } catch (Exception e) {
            println e.message
        }
    }

    def recibirParcialProblema(long prestamoDetalle, boolean perdido) {

        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            prestamoService.recibirParcialProblema(prestamoDetalleTmp, currentUser, perdido)
            redirect(controller: 'prestamo', action: 'recibir', params: [id: prestamoDetalleTmp.prestamo.id])
        }
        catch (Exception e) {
            println e.message
        }
    }

    /**
     *
     * @param id
     */
    def imprimirPrestamo(long id, boolean recibir) {
        println("Imprimiendo prestamo: $id")
        def documento = reportesService.generarReportePrestamoPdf(id, recibir)
        Utilidades.descargaArchivo(documento, "Prestamo_$id", "pdf", response, false)
    }

    /**
     *
     * @param vencidos
     */
    def imprimirPrestamos(boolean vencidos) {
        println("Imprimiendo prestamos vencidos")
        def documento = reportesService.generarReportePrestamosVencidosPdf(vencidos)
        Utilidades.descargaArchivo(documento, "Prestamos_Vencidos", "pdf", response, false)
    }

}
