package gestion_equipos_controlados

import edu.pucmm.eict.util.Utilidades
import gestion_equipos_controlados.auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperPrintManager
import org.springframework.security.access.annotation.Secured

import java.nio.file.Files
import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN'])
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

    def recibir(long prestamo) {
        def prestamoTmp = Prestamo.findById(prestamo)
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
        redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamo])
    }

    def recibirParcial() {
        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            def prestamoDetalleTmp = PrestamoDetalle.findById(params.prestamoDetalle as long)
            prestamoService.recibirParcial(prestamoDetalleTmp, currentUser)
            redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamoDetalleTmp.prestamo.id])
        } catch (Exception e) {
            println e.message
        }
    }

    def recibirParcialProblema(long prestamoDetalle, boolean perdido) {

        try {
            def currentUser = (User) springSecurityService.getCurrentUser()
            def prestamoDetalleTmp = PrestamoDetalle.findById(prestamoDetalle)
            prestamoService.recibirParcialProblema(prestamoDetalleTmp, currentUser, perdido)
            redirect(controller: 'prestamo', action: 'recibir', params: [prestamo: prestamoDetalleTmp.prestamo.id])
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
}
