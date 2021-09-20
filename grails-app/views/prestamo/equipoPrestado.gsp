<%@ page import="gestion_equipos_controlados.CategoriaEquipo; gestion_equipos_controlados.Equipo; gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Listado de Equipos Préstado</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">
    Listado de Equipo #${equipo.id} - ${equipo.nombre} Prestados
</content>
<content tag="content">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Préstamo</th>
                                <th class="border-top-0">Estudiante</th>
                                <th class="border-top-0">Matrícula</th>
                                <th class="border-top-0">Fecha Solicitud</th>
                                <th class="border-top-0">Fecha Entrega</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${listaPrestamos}" var="p">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="">
                                                <h4 class="m-b-0 font-16">
                                                    <g:link controller="prestamo" action="recibir" id="${p.prestamo.id}">
                                                        ${p.prestamo.id}
                                                    </g:link>
                                                </h4>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${p.prestamo.nombreEstudiante}</td>
                                    <td>${p.prestamo.matriculaEstudiante}</td>
                                    <td>${p.prestamo.fechaSolicitud.format("dd/MM/yyyy")}</td>
                                    <td>${p.prestamo.fechaEntrega.format("dd/MM/yyyy")}</td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Préstamo</th>
                                <th class="border-top-0">Estudiante</th>
                                <th class="border-top-0">Matrícula</th>
                                <th class="border-top-0">Fecha Solicitud</th>
                                <th class="border-top-0">Fecha Entrega</th>
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