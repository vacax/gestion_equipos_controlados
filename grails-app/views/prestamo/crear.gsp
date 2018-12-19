<%@ page import="gestion_equipos_controlados.Equipo; gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <title></title>
    <content tag="title">Préstamos</content>
    <content tag="css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet"/>
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
        <asset:stylesheet src="pickadate/lib/themes/default.css"/>
        <asset:stylesheet src="pickadate/lib/themes/default.date.css"/>
        <asset:stylesheet src="pickadate/lib/themes/default.time.css"/>
    </content>
</head>

<body>
<content tag="content_title">Crear Préstamo</content>
<content tag="content">
    <g:form class="needs-validation form" controller="equipo" action="save" method="post">

        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nuevo préstamo</h4>

                <div class="form-row">
                    <div class="col-md-6">
                        <label for="nombreEstudiante">Nombre del Estudiante</label>
                        <input type="text" class="form-control" id="nombreEstudiante" name="nombreEstudiante"
                               placeholder="Nombre del Estudiante" value="" required>

                        <div id="nombre-valido" style="color: red; display: none;">
                            * No disponible!
                        </div>
                        <br>
                    </div>

                    <div class="col-md-6">
                        <label for="matriculaEstudiante">Matrícula del Estudiante</label>
                        <input type="text" class="form-control" id="matriculaEstudiante" name="matriculaEstudiante"
                               placeholder="Matrícula del Estudiante" value="" required>

                        <div id="matricula-valido" style="color: red; display: none;">
                            * No disponible!
                        </div>
                        <br>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="fechaEntrega">Fecha Entrega</label>
                        <input class="form-control pickadate" placeholder="Seleccione una fecha" id="fechaEntrega" name="fechaEntrega" required>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Lista de Equipos</h4>
                        <h5 class="card-subtitle">Listado de todos los equipos</h5>

                        <div class="table-responsive">
                            <input value="0" id="equipoSeleccionado" hidden>
                            <table id="zero_config" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th class="border-top-0">Nombre</th>
                                    <th class="border-top-0">Categoría</th>
                                    <th class="border-top-0">Cantidad Disponible</th>
                                    <th class="border-top-0">Serial</th>
                                    <th class="border-top-0">Acciones</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                <g:each in="${Equipo.findAllByHabilitado(true)}" var="equipo">
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="">
                                                <h4 class="m-b-0 font-16">${equipo.nombre}</h4>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${equipo.categoriaEquipo.categoria}</td>
                                    <td>${equipo.cantidadDisponible}</td>
                                    <td>
                                        <g:if test="${equipo.serial}">
                                            Si
                                        </g:if>
                                        <g:else>
                                            No
                                        </g:else>
                                    </td>
                                    <td>
                                        <g:if test="${equipo.serial}">
                                            <button type="button" class="btn btn-primary" data-toggle="modal"
                                                    data-target="#modal"
                                                    data-whatever="${equipo.id}">Agregar</button>
                                        </g:if>
                                        <g:else>
                                            <button type="button" class="btn btn-primary" data-toggle="modal"
                                                    data-target="#modalNoSerial"
                                                    onclick="cambiarEquipoSeleccionado(${equipo.id})"
                                                    data-whatever="${equipo.id}">Agregar</button>
                                        </g:else>
                                    </td>
                                    </tr>
                                </g:each>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="border-top-0">Nombre</th>
                                    <th class="border-top-0">Categoría</th>
                                    <th class="border-top-0">Cantidad Disponible</th>
                                    <th class="border-top-0">Serial</th>
                                    <th class="border-top-0">Acciones</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Equipos a Prestar</h4>

                        <div class="table-responsive">
                            <table id="equiposPrestar" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th class="border-top-0">Nombre</th>
                                    <th class="border-top-0">Cantidad</th>
                                    <th class="border-top-0">Serial</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th class="border-top-0">Nombre</th>
                                    <th class="border-top-0">Cantidad</th>
                                    <th class="border-top-0">Serial</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal" tabindex="-1" role="dialog"
             aria-labelledby="modalLabel1">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalLabel1">Buscar Equipo Serial</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    </div>

                    <div class="modal-body">
                        <div class="form-group">
                            <label for="equipoSerialInput" class="control-label">Serial:</label>
                            <input type="text" class="form-control" id="equipoSerialInput">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" id="BuscarBtn" onclick="buscarEquipoSerial()"
                                class="btn btn-primary">Buscar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.modal -->

        <div class="modal fade" id="modalNoSerial" tabindex="-1" role="dialog"
             aria-labelledby="modalLabel1">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalNoSerialLabel1">Cantidad a Agregar</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    </div>

                    <div class="modal-body">
                        <div class="form-group">
                            <label for="cantidadEquipoNoSerial" class="control-label">Cantidad:</label>
                            <input type="text" class="form-control" id="cantidadEquipoNoSerial">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" id="Aceptar" onclick="agregarEquipoNoSerial()"
                                class="btn btn-primary">Buscar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.modal -->
    </g:form>
    <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>

</content>
<content tag="js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <asset:javascript src="DataTables/datatables.min.js"/>
    <asset:javascript src="dist/js/pages/datatable/datatable-basic.init.js"/>
    <asset:javascript src="pickadate/lib/compressed/picker.js"/>
    <asset:javascript src="pickadate/lib/compressed/picker.date.js"/>
    <asset:javascript src="pickadate/lib/compressed/picker.time.js"/>
    <asset:javascript src="pickadate/lib/compressed/legacy.js"/>
    <asset:javascript src="pickadate/lib/translations/es_ES.js"/>
    <script type="text/javascript">
        var dataPrestamo = [];

        $(document).ready(function () {
            $(".select").select2({
                placeholder: "Seleccione una categoría",
                allowClear: true,
                minimumResultsForSearch: 1
            });
            $("table").DataTable();
            $("#fechaEntrega").pickadate({
                format: 'dd/mm/yyyy'
            });
        });

        function cambiarEquipoSeleccionado(id) {
            $("#equipoSeleccionado").val(id);
        }

        function buscarEquipoSerial() {
            $.ajax({
                url: "/equipoSerial/buscarEquipoSerial/",
                data: {data: $("#equipoSerialInput").val()},
                method: 'GET',
                success: function (data) {
                    if (data.ok == true) {
                        var nuevaData = {
                            idEquipo: data.equipo.id,
                            idEquipoSerial: data.equipoSerial.id,
                            nombre: data.equipo.nombre,
                            cantidad: data.cantidad,
                            serial: data.equipoSerial.serial
                        };
                        refrescarData(nuevaData);
                        $('#modal').modal('toggle');
                    } else {
                        alert('¡El equipo no existe o ya esta prestado!')
                    }
                }
            });
        }

        function agregarEquipoNoSerial() {
            var cantidad = $("#cantidadEquipoNoSerial").val();
            var equipoId = $("#equipoSeleccionado").val();
            $.ajax({
                url: "/equipoSerial/agregarEquipoNoSerial/",
                data: {cantidadEquipo: cantidad, equipoId: equipoId},
                method: 'GET',
                success: function (data) {
                    if (data.ok == true) {
                        refrescarData({
                            idEquipo: data.equipo.id,
                            idEquipoSerial: data.equipoSerial.id,
                            nombre: data.equipo.nombre,
                            cantidad: data.cantidad,
                            serial: 'N/A'
                        });
                        $('#modalNoSerial').modal('toggle');
                    } else {
                        alert('No se pudo agregar este equipo.');
                    }
                }
            })
        }

        function refrescarData(nuevaData) {
            dataPrestamo.push(nuevaData);

            $('#equiposPrestar').DataTable({
                "data": dataPrestamo,
                "columns": [
                    {"data": "nombre"},
                    {"data": "cantidad"},
                    {"data": "serial"}
                ],
                "destroy": true
            });
        }

        $("#aceptarBtn").on('click', function (event) {
            var nombreEstudiante = $("#nombreEstudiante").val();
            var matriculaEstudiante = $("#matriculaEstudiante").val();
            var fechaEntrega = $("#fechaEntrega").val();
            var dataEstudiante = {nombre: nombreEstudiante, matricula: matriculaEstudiante, fechaEntrega: fechaEntrega};

            if(nombre && matriculaEstudiante && fechaEntrega && dataEstudiante){
                $.ajax({
                    url: "/prestamo/save/",
                    type: 'POST',
                    data: {
                        estudiante: JSON.stringify(dataEstudiante),
                        dataPrestamo: JSON.stringify(dataPrestamo)
                    },
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        if (result == true) {
                            window.location.href = "/prestamo/index";
                        } else {
                            alert('¡Ha habido un problema al procesar su solicitud!')
                        }
                    }
                })
            } else {
                alert('!Hay datos que no estan completos!');
            }
        })
    </script>
</content>
</body>
</html>