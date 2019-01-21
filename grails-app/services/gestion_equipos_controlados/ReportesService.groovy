package gestion_equipos_controlados

import edu.pucmm.eict.encapsulaciones.reportes.PrestamoJRDataSource
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
     * @param prestamoId
     * @return
     */
    JasperPrint generarReportePrestamoRaw(long prestamoId){
        //Cargando el reporte desde la carpeta recurso.
        JasperReport reporte = (JasperReport) JRLoader.loadObject(this.getClass().getResourceAsStream("/reportes/prestamos/prestamo.jasper"))
        //Parametros.
        HashMap<String, Object> parametros=new HashMap<>();
        parametros.put("logo_reporte", this.getClass().getResourceAsStream("/logopucmm.png")) //
        //
        PrestamoJRDataSource p = new PrestamoJRDataSource(Prestamo.get(prestamoId))
        //Mandando a ejecutar el proyecto.
        JasperPrint print = JasperFillManager.fillReport(reporte, parametros, p);

        return print;
    }



    /**
     * 
     * @param jasperPrint
     * @return
     */
    FileInputStream convertirReporteaPdf(JasperPrint jasperPrint){
        File archivoTemp = File.createTempFile("gec_",".pdf")
        byte[] archivoArreglo = JasperExportManager.exportReportToPdf(jasperPrint)
        Path path = Files.write(archivoTemp.toPath(), archivoArreglo)
        new FileInputStream(archivoTemp)
    }

    /**
     *
     * @param prestamoId
     * @return
     */
    FileInputStream generarReportePrestamoPdf(long prestamoId){
        return convertirReporteaPdf(generarReportePrestamoRaw(prestamoId))
    }
}
