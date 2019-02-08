package edu.pucmm.eict.encapsulaciones.reportes

import gestion_equipos_controlados.Prestamo
import net.sf.jasperreports.engine.JRDataSource
import net.sf.jasperreports.engine.JRException
import net.sf.jasperreports.engine.JRField

/**
 *
 */
class PrestamosVencidosJRDataSource implements JRDataSource {

    private List<Prestamo> prestamos
    private int indice = -1

    PrestamosVencidosJRDataSource(List<Prestamo> prestamos) {
        this.prestamos = prestamos
    }

    @Override
    boolean next() throws JRException {
        indice++
        return indice < prestamos.size()
    }

    @Override
    Object getFieldValue(JRField jrField) throws JRException {
        Object tmp = null

        //buscando el valor de la propiedad de frente
        tmp = prestamos.properties.get(jrField.name)
        if (!tmp) {
            tmp = prestamos.getAt(indice).properties.get(jrField.name)
        }

        //si la propiedad no existe en el objeto la busco.
        switch (jrField.name) {
            case "nombreEstudiante":
                tmp = prestamos.getAt(indice).nombreEstudiante
                break
            case "matriculaEstudiante":
                tmp = prestamos.getAt(indice).matriculaEstudiante
                break
            case "fechaEntrega":
                tmp = prestamos.getAt(indice).fechaEntrega
                break
        }

        println("La consulta campo: ${jrField.name} valor: ${tmp}")
        return tmp
    }


}
