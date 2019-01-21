package edu.pucmm.eict.encapsulaciones.reportes

import gestion_equipos_controlados.Prestamo
import net.sf.jasperreports.engine.JRDataSource
import net.sf.jasperreports.engine.JRException
import net.sf.jasperreports.engine.JRField

/**
 *
 */
class PrestamoJRDataSource implements JRDataSource {

    private Prestamo prestamo
    private int indice=0

    PrestamoJRDataSource(Prestamo prestamo){
        this.prestamo = prestamo
    }

    @Override
    boolean next() throws JRException {
        indice++
        return indice < prestamo.listaPrestamoDetalle.size()
    }

    @Override
    Object getFieldValue(JRField jrField) throws JRException {
        Object tmp = null

        //buscando el valor de la propiedad de frente
        tmp = prestamo.properties.get(jrField.name)
        if(!tmp){
           tmp = prestamo.listaPrestamoDetalle.getAt(indice).properties.get(jrField.name)
        }

        //si la propiedad no existe en el objeto la busco.
        switch (jrField.name){
            case "estadoPrestamo":
                tmp = prestamo.estadoPrestamo.estado
                break
            case "equipo":
                tmp = prestamo.listaPrestamoDetalle.getAt(indice).equipoSerial.equipo.nombre
                break
            case "serial":
                tmp = prestamo.listaPrestamoDetalle.getAt(indice).equipoSerial.serial
                break
            case "cantidad":
                tmp = prestamo.listaPrestamoDetalle.getAt(indice).cantidadPrestado
                break
            case "estadoEquipo":
                tmp = prestamo.listaPrestamoDetalle.getAt(indice).entregado ? "Entregado" : "Pendiente"
                break
        }

        println("La consulta campo: ${jrField.name} valor: ${tmp}")
        return tmp
    }

    
}
