<%@ page import="gestion_equipos_controlados.Equipo;" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Movimientos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
        <asset:stylesheet src="sweetalert2/dist/sweetalert2.min.css"/>
    </content>
</head>

<body>
<content tag="content_title">Movimientos</content>
<content tag="content">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Registrar Nueva Salida</h4>
                    <h5 class="card-subtitle">Listado de Equipos</h5>

                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Serial</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${listadoEquipos}" var="equipo">
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="">
                                            <h4 class="m-b-0 font-16">${equipo.equipo.nombre}</h4>
                                        </div>
                                    </div>
                                </td>
                                <td>${equipo.serial}</td>
                                <td><g:if test="${equipo.habilitado}">
                                    <label class="label label-success">Habilitado</label>
                                </g:if>
                                    <g:else>
                                        <label class="label label-danger">Deshabilitado</label>
                                    </g:else></td>
                                <td><button
                                        onclick="seleccionarEquipo(${equipo.id}, '${equipo.equipo.nombre}', '${equipo.serial}');"
                                        class="btn btn-danger">Seleccionar</button></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Serial</th>
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
    <asset:javascript src="sweetalert2/dist/sweetalert2.all.min.js"/>
    <asset:javascript src="sweetalert2/sweet-alert.init.js"/>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();
        })
    </script>
    <script>
        function seleccionarEquipo(id, nombre, serial) {
            var equipo = id;
            swal({
                title: '¡ATENCIÓN!',
                text: "Seguro de Eliminar el " + nombre + " con serial: " + serial,
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar'
            }).then(function (result) {
                if (result.value) {
                    $.ajax({
                        type: "post",
                        url: "/movimiento/guardarSalida/",
                        data: {data: equipo},
                        success: function () {
                            window.location = "/movimiento/index/"
                        }
                    });
                }
            });
        }
    </script>
</content>
</body>
</html>