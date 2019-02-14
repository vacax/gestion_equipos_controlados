package gestion_equipos_controlados

import edu.pucmm.eict.encapsulaciones.reportes.PrestamoJRDataSource
import edu.pucmm.eict.encapsulaciones.reportes.PrestamosVencidosJRDataSource
import grails.gorm.transactions.Transactional
import jxl.Cell
import jxl.CellView
import jxl.Workbook
import jxl.format.Alignment
import jxl.format.Border
import jxl.format.BorderLineStyle
import jxl.format.VerticalAlignment
import jxl.write.Label
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
import net.sf.jasperreports.engine.JasperExportManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import net.sf.jasperreports.engine.util.JRLoader

import javax.servlet.http.HttpServletResponse
import java.nio.file.Files
import java.nio.file.Path
import java.text.SimpleDateFormat

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

    JasperPrint generarReportePrestamosVencidosRaw(boolean vencidos) {
        def path = "/reportes/prestamos/prestamos_list.jasper"
        JasperReport reporte = (JasperReport) JRLoader.loadObject(this.getClass().getResourceAsStream(path))

        //Parametros.
        HashMap<String, Object> parametros = new HashMap<>();
        parametros.put("logo_reporte", this.getClass().getResourceAsStream("/logopucmm.png")) //

        vencidos ? parametros.put("titulo", 'Préstamos Vencidos') : parametros.put("titulo", 'Préstamos Activos')

        def prestamos
        if (vencidos) {
            parametros.put("titulo", 'Préstamos Vencidos')
            prestamos = Prestamo.prestamosVencidosAll()
        } else {
            parametros.put("titulo", 'Préstamos Activos')
            prestamos = Prestamo.prestamosActivos()
        }


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

    FileInputStream generarReportePrestamosVencidosPdf(boolean vencidos) {
        return convertirReporteaPdf(generarReportePrestamosVencidosRaw(vencidos))
    }

    def descargarReporteXls(def response, boolean vencidos){
        def prestamos
        def titulo
        SimpleDateFormat sdf = new SimpleDateFormat('dd/MM/yyyy')
        def fecha = new Date().format('dd/MM/yyyy')
        response.setContentType('application/vnd.ms-excel')
        if(!vencidos){
            response.setHeader('Content-Disposition', 'Attachment;Filename="ListadoPrestamos.xls"')
            prestamos = Prestamo.prestamosActivos()
            titulo = "Listado de Prestamos Activos"
        }
        else{
            response.setHeader('Content-Disposition', 'Attachment;Filename="ListadoPrestamosVencidos.xls"')
            prestamos = Prestamo.prestamosVencidosAll()
            titulo = "Listado de Prestamos Vencidos"
        }

        WritableWorkbook workbook = Workbook.createWorkbook(response.outputStream)
        WritableSheet sheet1 = workbook.createSheet("Listado", 0)

        WritableFont cellFontTitulo = new WritableFont(WritableFont.TIMES, 12)
        cellFontTitulo.setBoldStyle(WritableFont.BOLD)

        WritableFont cellFont = new WritableFont(WritableFont.TIMES, 12)
        WritableCellFormat cellFormatTitulo = new WritableCellFormat(cellFontTitulo)
        WritableCellFormat cellFormat = new WritableCellFormat(cellFont)
        cellFormatTitulo.setAlignment(Alignment.CENTRE)
        cellFormatTitulo.setVerticalAlignment(VerticalAlignment.CENTRE)
        cellFormatTitulo.setBorder(Border.ALL, BorderLineStyle.THIN)
        cellFormat.setAlignment(Alignment.CENTRE)
        cellFormat.setVerticalAlignment(VerticalAlignment.CENTRE)
        cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN)

        sheet1.mergeCells(1,0,3,0)
        sheet1.addCell(new Label(1, 0, titulo, cellFormatTitulo))


        sheet1.addCell(new Label(0, 1, "", cellFormatTitulo))
        sheet1.addCell(new Label(1, 1, "Estudiante", cellFormatTitulo))
        sheet1.addCell(new Label(2, 1, "Matricula", cellFormatTitulo))
        sheet1.addCell(new Label(3, 1, "Fecha de Entrega", cellFormatTitulo))

        prestamos.eachWithIndex { it, index ->
            sheet1.addCell(new Label(0, index + 2, index + 1 as String, cellFormat))
            sheet1.addCell(new Label(1, index + 2, it.nombreEstudiante as String, cellFormat))
            sheet1.addCell(new Label(2, index + 2, it.matriculaEstudiante as String, cellFormat))
            sheet1.addCell(new Label(3, index + 2, it.fechaEntrega as String, cellFormat))
        }

        def cantidadColumnas = sheet1.getColumns()

        cantidadColumnas.times {
            CellView cell = sheet1.getColumnView(it)
            cell.setAutosize(true)
            sheet1.setColumnView(it, cell)
        }

        sheet1.addCell(new Label(3, sheet1.getRows() + 1, "Generado: " + fecha, cellFormatTitulo))

        workbook.write()
        workbook.close()
    }
}
