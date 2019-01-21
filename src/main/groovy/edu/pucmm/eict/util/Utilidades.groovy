package edu.pucmm.eict.util

class Utilidades {

    /**
     * 
     * @param archivo
     * @param nombre
     * @param tipo
     * @param response
     * @param descargaDirecta
     * @return
     */
    static def descargaArchivo(def archivo, String nombre, String tipo, def response, boolean descargaDirecta =false){
        def typeContext="";
        if(tipo=='pdf'){
            typeContext="application/pdf";
        }else if(tipo=='excel'){
            typeContext="application/vnd.ms-excel";
        }else if(tipo == 'zip'){
            typeContext="application/zip";
        }
        if(descargaDirecta){
            response.setHeader("Content-disposition", "attachment; filename=$nombre");
        }
        response.contentType=typeContext;
        response.outputStream << archivo;
        response.outputStream.flush();
    }
}
