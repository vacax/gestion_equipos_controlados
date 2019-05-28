<%@ page import="gestion_equipos_controlados.Equipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <title></title>
    <content tag="title">Movimientos</content>
    <content tag="css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet"/>
    </content>
</head>

<body>
<content tag="content_title">Registro de Movimientos</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Nueva Entrada</h4>
                <g:form class="needs-validation form" controller="movimiento" action="guardarEntrada" method="post" id="registrarEntrada">
                    <div class="form-row">
                        <div class="col-md-6">
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
                        <button id="registrarBtn" class="btn btn-success">Registrar</button>
                    </div>
            </div>

                <div class="form-row">
                    <div class="col-md-6">
                        <label for="comentario">Comentario</label>
                        <textarea type="text" class="form-control" id="comentario" name="comentario"
                                  placeholder="Comentario" rows="2" required="required"></textarea>
                    </div>
                </div>
                </g:form>
        </div>
    </div>
    </div>
</content>
<content tag="js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

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

        })
    </script>
</content>
</body>
</html>