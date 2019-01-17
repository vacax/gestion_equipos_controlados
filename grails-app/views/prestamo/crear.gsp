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
        <asset:stylesheet src="sweetalert2/dist/sweetalert2.min.css"/>
    </content>
</head>

<body>
<content tag="content_title">Crear Préstamo</content>
<content tag="content">
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
                    <input class="form-control pickadate" placeholder="Seleccione una fecha" id="fechaEntrega"
                           name="fechaEntrega" required>
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
                                                onclick="cambiarEquipoSeleccionado('${equipo.id}', '${equipo.nombre}')"
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
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Cantidad</th>
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
                    <h4 class="modal-title" id="modalNoSerialLabel1">
                        Cantidad de <span id="equipoSeleccionadoSpan">*aqui*</span> a agregar</h4>
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
    <asset:javascript src="sweetalert2/dist/sweetalert2.all.min.js"/>
    <asset:javascript src="sweetalert2/sweet-alert.init.js"/>
    <asset:javascript src="inputmask/dist/min/jquery.inputmask.bundle.min.js"/>
    <script type="text/javascript">
        var dataPrestamo = [];

        $(document).ready(function () {
            $(".select").select2({
                placeholder: "Seleccione una categoría",
                allowClear: true,
                minimumResultsForSearch: 1
            });
            $("#zero_config").DataTable();
            var pickerInput = $("#fechaEntrega").pickadate({
                format: 'dd/mm/yyyy',
                today: false
            });

            var picker = pickerInput.pickadate('picker');
            picker.set('min', new Date())

        });

        function cambiarEquipoSeleccionado(id, nombre) {
            $("#equipoSeleccionado").val(id);
            $("#equipoSeleccionadoSpan").text(nombre);
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
                        swal({
                            title: "¡ATENCIÓN!",
                            text: "¡El equipo no existe o ya esta prestado!",
                            type: "warning",
                            closeOnConfirm: false
                        });
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
                            idEquipoSerial: null,
                            nombre: data.equipo.nombre,
                            cantidad: data.cantidad,
                            serial: 'N/A'
                        });
                        //Cerrar el modal.
                        $('#modalNoSerial').modal('toggle');
                    } else {
                        swal({
                            title: "¡ATENCIÓN!",
                            text: "Hubo un problema al agregar el equipo. Puede que la cantidad requerida no este disponible.",
                            type: "warning",
                            closeOnConfirm: false
                        });
                    }
                }
            })
        }

        function refrescarData(nuevaData) {
            dataPrestamo.push(nuevaData);
            agregarFilaTablaPrestamos(nuevaData)
        }

        function eliminarRow(id) {
            for (var i = 0; i < dataPrestamo.length; i++) {
                if (dataPrestamo[i].idEquipo === id) {
                    dataPrestamo.splice(i, 1);
                }
            }

            $("#equiposPrestar tbody").html('');
            for (var i = 0; i < dataPrestamo.length; i++) {
                agregarFilaTablaPrestamos(dataPrestamo[i])
            }
        }

        function agregarFilaTablaPrestamos(data) {
            var newRow = $("<tr>");
            var cols = "";

            cols += '<td>' + data.nombre + '</td>';
            cols += '<td>' + data.cantidad + '</td>';
            cols += '<td>' + data.serial + '</td>';
            cols += '<td><button class="btn btn-primary ibtnDel" id="btn_' + data.idEquipo + '" ' +
                'onclick="eliminarRow(' + data.idEquipo + ')">Eliminar</button></td>';

            newRow.append(cols);
            $("#equiposPrestar").append(newRow);
        }


        $("#aceptarBtn").on('click', function (event) {
            var nombreEstudiante = $("#nombreEstudiante").val();
            var matriculaEstudiante = $("#matriculaEstudiante").val();
            var fechaEntrega = $("#fechaEntrega").val();
            var dataEstudiante = {nombre: nombreEstudiante, matricula: matriculaEstudiante, fechaEntrega: fechaEntrega};

            if (nombreEstudiante && matriculaEstudiante && fechaEntrega && dataEstudiante) {
                if (dataPrestamo.length > 0) {
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
                                swal({
                                    title: "¡ATENCIÓN!",
                                    text: "¡Ha habido un problema al procesar su solicitud!",
                                    type: "warning",
                                    closeOnConfirm: false
                                });
                            }
                        }
                    })
                } else {
                    swal({
                        title: "ATENCIÓN",
                        text: "¡Debe agregar al menos un equipo al préstamo!",
                        type: "warning",
                        closeOnConfirm: false
                    });
                }
            } else {
                swal({
                    title: "ATENCIÓN",
                    text: "¡Hay datos que no estan completos!",
                    type: "warning",
                    closeOnConfirm: false
                });
            }
        })
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#matriculaEstudiante").inputmask("9999-9999")
        })
    </script>
</content>
</body>
</html>