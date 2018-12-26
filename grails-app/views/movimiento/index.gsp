
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Movimientos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet"/>
    </content>
</head>

<body>
<content tag="content_title">Movimientos</content>
<content tag="content">

    <div class="row">
        <div class="col-md-2">
            <button class="btn btn-info" id="registrarEntradaBtn">Registrar Entrada</button>
        </div>
        <div class="col-md-3">
            <a class="btn btn-info" href="/movimiento/crearSalida">Registrar Salida</a>
        </div>
    </div>
    <br>
    <div id="formRegistrarEntrada" style="display:none;">
    <g:form class="needs-validation form" controller="movimiento" action="guardarEntrada" method="post" id="registrarEntrada">
        <div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Nueva Entrada Equipo</h4>
    <div class="form-row">
        <div class="col-md-5">
            <label for="equipo">Equipo</label>
            <select class="select" style="width: 100%" id="equipo" name="equipo" required>
                <option></option>
        <g:each in="${listadoEquipos}" var="equipo">
            <option value="${equipo.id}">${equipo.nombre}</option>
        </g:each>
        </select>
    </div>

        <div class="col-md-1">
            <label for="cantidad">Cantidad</label>
            <input type="number" min="1" step="1" class="form-control" id="cantidad" name="cantidad"
                   placeholder="Cantidad" value="1" required>
        </div>
        <div id="campoSerial" name="campoSerial" style="display: none;">
            <label for="cantidad" id="labelSerial">Serial</label>
            <input type="text" class="form-control" id="serial" name="serial"
                   placeholder="Digite Serial">
        </div>
        <div class="col-md-1">
            <label for="registrarBtn">.</label>
            <button id="registrarBtn" class="btn btn-success disabled">Registrar</button>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
    </g:form>
    </div>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <!--This page plugins -->
    <asset:javascript src="DataTables/datatables.min.js"/>
    <asset:javascript src="dist/js/pages/datatable/datatable-basic.init.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();

            $(".select").select2({
                placeholder: "Seleccione un Equipo",
                allowClear: true,
                minimumResultsForSearch: 1
            });

            $("#equipo").on('change', function (event) {
                var equipo = $("#equipo").val();
                $.ajax({
                    url: "/movimiento/verificarNecesitaSerial/",
                    data: {data: equipo},
                    success: function (data) {
                        if (data === 'true') {
                            //NECESITA SERIAL
                            $("#campoSerial").css('display', 'block');
                            $('#cantidad').prop('readonly', true);
                            $("#cantidad").val(1);
                            $("#serial").prop('required', true);
                            $("#serial").val('');

                        } else if (data === 'false') {
                            //no necesita serial
                            $("#campoSerial").css('display', 'none');
                            $('#cantidad').prop('readonly', false);
                            $("#cantidad").val(1);
                            $("#serial").prop('required', false);
                            $("#serial").val('');

                        } else {
                            alert('No existe el equipo que se quiere procesar.');
                        }
                    }
                });
            });

            $("#registrarEntradaBtn").on('click', function (event) {
                $("#formRegistrarEntrada").toggle();
            });

        })
    </script>
</content>
</body>
</html>