<%@ page import="gestion_equipos_controlados.EstadoPrestamo; gestion_equipos_controlados.EstadoEquipo;" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Prestamo</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
        <asset:stylesheet src="sweetalert2/dist/sweetalert2.min.css"/>
    </content>
</head>

<body>
<content tag="content_title">Detalle de Préstamo</content>
<content tag="content">
    <g:if test="${prestamo.estadoPrestamo.codigo == EstadoPrestamo.DEVUELTO}">
        <div id="divPrestamoCompleto">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title"
                                style="text-align: center;">PRÉSTAMO DEVUELTO SATISFACTORIAMENTE!</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </g:if>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Préstamo del estudiante: ${prestamo.nombreEstudiante}</h4>
                    <h5 class="card-subtitle">Detalles</h5>
                    <h5 class="card-title"><pre>Estado:                 <b>${prestamo.estadoPrestamo.estado}</b></pre></h5>
                    <h5 class="card-title"><pre>Fecha Solicitud:        <b>${prestamo.fechaSolicitud}</b></pre></h5>
                    <h5 class="card-title"><pre>Fecha Límite:           <b>${prestamo.fechaEntrega}</b></pre></h5>
                    <h5 class="card-title"><pre>Entregado Por:          <b>${prestamo.listaPrestamoDetalle.first().usuarioEntrega.name}</b></pre></h5>
                    <br>
                    <div class="row">
                        <div class="col-md-2">
                            <g:if test="${prestamo.estadoPrestamo.codigo != EstadoPrestamo.DEVUELTO}">
                                <a class="btn btn-success" id="recibirTodoBtn" href="#"
                                   onclick="recibirTodo('${prestamo.id}')">Entregar Todo</a>
                            </g:if>
                        </div>
                        <div class="col-md-2">
                            <g:link class="btn btn-info" target="_blank" controller="prestamo" action="imprimirPrestamo" id="${prestamo.id}" params="[recibir : true]">Imprimir</g:link>
                        </div>
                    </div>
                    <br>

                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Equipo</th>
                                <th class="border-top-0">Serial</th>
                                <th class="border-top-0">Cant</th>
                                <th class="border-top-0">Estado</th>
                                <th class="border-top-0">Recibido Por</th>
                                <th class="border-top-0">Fecha</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${prestamo.listaPrestamoDetalle}" var="prestamoDetalle">
                                <td>${prestamoDetalle.equipoSerial.equipo.nombre}</td>
                                <td>${prestamoDetalle.equipoSerial.serial}</td>
                                <td>${prestamoDetalle.cantidadPrestado}</td>
                                <td>
                                    <g:if test="${prestamoDetalle.entregado}">
                                        <label class="label label-success">Entregado</label>
                                    </g:if>
                                    <g:else>
                                        <label class="label label-danger">Pendiente</label>
                                    </g:else>
                                </td>
                                <td>
                                    <g:if test="${prestamoDetalle.usuarioRecibo}">
                                        ${prestamoDetalle.usuarioRecibo.name}
                                    </g:if>
                                </td>
                                <td>
                                    <g:if test="${prestamoDetalle.fechaRecibo}">
                                        <g:formatDate format="dd-MM-yyyy" date="${prestamoDetalle.fechaRecibo}"/>
                                    </g:if>
                                </td>
                                <td>
                                    <g:if test="${!prestamoDetalle.entregado}">
                                        <g:link class="btn btn-info" controller="prestamo" action="recibirParcial" id="${prestamoDetalle.id}">Entregar</g:link>
                                        <a class="btn btn-danger"
                                           href="#" onclick="recibirAnomalia('${prestamoDetalle.id}', '${prestamoDetalle.prestamo.id}')">Anomalía</a>
                                    </g:if>
                                    <g:else>
                                        ${prestamoDetalle.nota}
                                    </g:else>


                                </td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Equipo</th>
                                <th class="border-top-0">Serial</th>
                                <th class="border-top-0">Cant</th>
                                <th class="border-top-0">Estado</th>
                                <th class="border-top-0">Recibido Por</th>
                                <th class="border-top-0">Fecha</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</content>
<content tag="js">
    <!--This page plugins -->
    <asset:javascript src="DataTables/datatables.min.js"/>
    <asset:javascript src="dist/js/pages/datatable/datatable-basic.init.js"/>
    <asset:javascript src="sweetalert2/dist/sweetalert2.all.min.js"/>
    <asset:javascript src="sweetalert2/sweet-alert.init.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();
        });

        function recibirTodo(idPrestamo) {
            var path = '/prestamo/recibirTodo?prestamo=' + idPrestamo;
            swal({
                title: '¡ATENCIÓN!',
                text: "¿Seguro que quiere recibir todo?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar'
            }).then(function (result) {
                if (result.value) {
                    $.get(path, function (data, status) {
                        if (status === 'success') {
                            window.location.href = '/prestamo/recibir/' + idPrestamo;
                        }
                    });
                }
            });
        }

        function recibirAnomalia(idPrestamoDetalle, idPrestamo) {
            var path = '/prestamo/recibirParcialProblema?prestamoDetalle=' + idPrestamoDetalle + '&perdido=false';
            var path_dano = '/prestamo/recibirParcialProblema?prestamoDetalle=' + idPrestamoDetalle + '&perdido=true';
            swal({
                title: 'REPORTAR ANOMALÍA',
                text: "¿Que paso con el equipo?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Está Perdido',
                cancelButtonText: 'Está Dañado'
            }).then(function (result) {
                if (result.value) {
                    $.get(path_dano, function (data, status) {
                        if (status === 'success') {
                            window.location.href = '/prestamo/recibir/' +idPrestamo;
                        }
                    });
                }
                else if (result.dismiss === Swal.DismissReason.cancel){
                    $.get(path, function (data, status) {
                        if (status === 'success') {
                            window.location.href = '/prestamo/recibir/' + idPrestamo;
                        }
                    });
                }
            });
        }

    </script>
</content>
</body>
</html>