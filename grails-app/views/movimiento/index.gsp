
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Movimientos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">Movimientos</content>
<content tag="content">

    <div class="row">
        <div class="col-md-2">
            <a class="btn btn-info" href="/movimiento/crearEntrada">Registrar Entrada</a>
        </div>
        <div class="col-md-3">
            <a class="btn btn-info" href="/movimiento/crearSalida">Registrar Salida</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Registro de Movimientos</h4>
                    <h5 class="card-subtitle">Listado de Movimientos</h5>
                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Tipo</th>
                                <th class="border-top-0">Equipo</th>
                                <th class="border-top-0">Cantidad</th>
                                <th class="border-top-0">Fecha</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${listadoMovimientos}" var="movimiento">
                                <td>
                                    <g:if test="${movimiento.tipoMovimiento.toString() == 'ENTRADA'}">
                                        <label class="label label-success">${movimiento.tipoMovimiento}</label>
                                    </g:if>
                                    <g:else>
                                        <label class="label label-danger">${movimiento.tipoMovimiento}</label>
                                    </g:else>
                                </td>
                                <td>${movimiento.equipo.nombre}</td>
                                <td>${movimiento.cantidad}</td>
                                <td>${movimiento.dateCreated}</td>
                                <td><a class="btn btn-info" href="#">Editar</a></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Tipo</th>
                                <th class="border-top-0">Equipo</th>
                                <th class="border-top-0">Cantidad</th>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();
        })
    </script>
</content>
</body>
</html>