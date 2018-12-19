<%@ page import="gestion_equipos_controlados.Prestamo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Préstamos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">Historial de Préstamos</content>
<content tag="content">

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Lista de Préstamos</h4>
                    <h5 class="card-subtitle">Listado de todos los préstamos hechos</h5>

                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Nombre del Estudiante</th>
                                <th class="border-top-0">Matrícula del Estudiante</th>
                                <th class="border-top-0">Fecha de Entrega</th>
                                <th class="border-top-0">Fecha Solicitud</th>
                                <th class="border-top-0">Estado del Préstamo</th>
                                <th class="border-top-0">Renovado</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${prestamos}" var="prestamo">
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="">
                                            <h4 class="m-b-0 font-16">${prestamo.nombreEstudiante}</h4>
                                        </div>
                                    </div>
                                </td>
                                <td>${prestamo.matriculaStudiante}</td>
                                <td>${prestamo.fechaEntrega}</td>
                                <td>${prestamo.fechaSolicitud}</td>
                                <td>${prestamo.estadoPrestamo.estado}</td>
                                <td>
                                    <g:if test="${prestamo.prestamoRenovado}">
                                        <a class="btn btn-primary"
                                           href="/prestamo/verRenovado/${prestamo.prestamoRenovado.id}">Ver Nuevo Préstamo</a>
                                    </g:if>
                                    <g:else>
                                        No
                                    </g:else>
                                </td>
                                <td>
                                    <g:if test="${prestamo.habilitado}">
                                        <label class="label label-success">Habilitado</label>
                                    </g:if>
                                    <g:else>
                                        <label class="label label-danger">Deshabilitado</label>
                                    </g:else>
                                </td>
                                <td><a class="btn btn-info" href="#">Editar</a></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Nombre del Estudiante</th>
                                <th class="border-top-0">Matrícula del Estudiante</th>
                                <th class="border-top-0">Fecha de Entrega</th>
                                <th class="border-top-0">Fecha Solicitud</th>
                                <th class="border-top-0">Estado del Préstamo</th>
                                <th class="border-top-0">Renovado</th>
                                <th class="border-top-0">Habilitado</th>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();
        })
    </script>
</content>
</body>
</html>