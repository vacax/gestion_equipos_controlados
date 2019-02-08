package gestion_equipos_controlados

import edu.pucmm.eict.encapsulaciones.reportes.PrestamoJRDataSource
import edu.pucmm.eict.encapsulaciones.reportes.PrestamosVencidosJRDataSource
import grails.gorm.transactions.Transactional
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import net.sf.jasperreports.engine.util.JRLoader

import java.nio.file.Files
import java.nio.file.Path

/**
 *
 */
@Transactional
class ReportesService {

    /**
     *
     * @param prestamoId , recibir
     * @return
     */
    JasperPrint generarReportePrestamoRaw(long prestamoId, boolean recibir) {
        //Cargando el reporte desde la carpeta recurso.
        //  JasperReport reporte = (JasperReport) JRLoader.loadObject(this.getClass().getResourceAsStream("/reportes/prestamos/prestamo.jasper"))
        def path = ""
        if (!recibir)
            path = "/reportes/prestamos/prestamo.jasper"
        else
            path = "/reportes/prestamos/recibirPrestamo.jasper"
        JasperReport reporte = (JasperReport) JRLoader.loadObject(this.getClass().getResourceAsStream(path))

        //Parametros.
        HashMap<String, Object> parametros = new HashMap<>();
        parametros.put("logo_reporte", this.getClass().getResourceAsStream("/logopucmm.png")) //
        //
        PrestamoJRDataSource p = new PrestamoJRDataSource(Prestamo.get(prestamoId))
        //Mandando a ejecutar el proyecto.
        JasperPrint print = JasperFillManager.fillReport(reporte, parametros, p);

        return print;
    }

    JasperPrint generarReportePrestamosVencidosRaw() {
        def path = "/reportes/prestamos_vencidos/prestamos_vencidos.jasper"
        JasperReport reporte = (JasperReport) JRLoader.loadObject(this.getClass().getResourceAsStream(path))

        //Parametros.
        HashMap<String, Object> parametros = new HashMap<>();
        parametros.put("logo_reporte", this.getClass().getResourceAsStream("/logopucmm.png")) //

        def prestamos = Prestamo.prestamosVencidos()

        PrestamosVencidosJRDataSource p = new PrestamosVencidosJRDataSource(prestamos as List<Prestamo>)
        //Mandando a ejecutar el proyecto.
        JasperPrint print = JasperFillManager.fillReport(reporte, parametros, p);

        return print;
    }

    /**
     *
     * @param jasperPrint
     * @return
     */
    FileInputStream convertirReporteaPdf(JasperPrint jasperPrint) {
        File archivoTemp = File.createTempFile("gec_", ".pdf")
        byte[] archivoArreglo = JasperExportManager.exportReportToPdf(jasperPrint)
        Path path = Files.write(archivoTemp.toPath(), archivoArreglo)
        new FileInputStream(archivoTemp)
    }

    /**
     *
     * @param prestamoId
     * @return
     */
    FileInputStream generarReportePrestamoPdf(long prestamoId, boolean recibir) {
        return convertirReporteaPdf(generarReportePrestamoRaw(prestamoId, recibir))
    }

    FileInputStream generarReportePrestamosVencidosPdf() {
        return convertirReporteaPdf(generarReportePrestamosVencidosRaw())
    }
}
