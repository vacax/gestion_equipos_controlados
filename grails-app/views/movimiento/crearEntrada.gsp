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
                <g:form class="needs-validation form" controller="movimiento" action="guardarEntrada" method="post">
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="equipo">Equipo</label>
                            <select class="select" style="width: 100%" id="equipo" name="equipo">
                                <option></option>
                                <g:each in="${listadoEquipos}" var="equipo">
                                    <option value="${equipo.id}">${equipo.nombre}</option>
                                </g:each>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="cantidad">Cantidad</label>
                            <input type="number" min="0" step="1" class="form-control" id="cantidad" name="cantidad"
                                   placeholder="Cantidad" value="0" required>
                        </div>
                        <div class="col-md-2">
                            <button id="procesarBtn" style="margin-top: 28px;" class="btn btn-info">Procesar</button>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-12">
                            <p id="puedeRegistrar"
                               style="color: green; display: none">* Todo en orden! El movimiento se puede registrar</p>

                            <p id="noPuedeRegistrar"
                               style="color: orangered; display: none;">* Estos equipos necesitan seriales!</p>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-12">
                            <div id="camposSeriales" class=""></div>
                        </div>
                    </div>

                    <button id="registrarBtn" class="btn btn-primary disabled" type="submit">Registrar</button>
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

            $("#procesarBtn").on('click', function (event) {
                event.preventDefault();
                //$("#cantidad").attr('disabled', 'disabled');
                var equipo = $("#equipo").val();
                $.ajax({
                    url: "/movimiento/verificarNecesitaSerial/",
                    data: {data: equipo},
                    success: function (data) {
                        if (data === 'true') {
                            //NECESITA SERIAL
                            $("#registrarBtn").addClass('disabled');
                            $("#noPuedeRegistrar").css('display', 'block');
                            $("#puedeRegistrar").css('display', 'none');

                            for (var i = 0; i < $("#cantidad").val(); i++) {
                                camposSeriales();
                            }

                        } else if (data === 'false') {
                            //NO NECESITA SERIAL
                            $("#registrarBtn").removeClass('disabled');
                            $("#puedeRegistrar").css('display', 'block');
                            $("#noPuedeRegistrar").css('display', 'none');
                            $("#camposSeriales").empty();
                        } else {
                            alert('No existe el equipo que se quiere procesar.');
                        }
                    }
                });
            });

            $("#registrarBtn").on('click', function (event) {
                if($(this).hasClass('disabled')){
                    event.preventDefault();
                }
            })
        })
    </script>
    <script>
        var numero = 0;
        function camposSeriales() {
            numero++;
            var objTo = document.getElementById('camposSeriales');
            var nuevoDiv = document.createElement("div");
            nuevoDiv.setAttribute("class", "form-group serial-div");
            nuevoDiv.innerHTML = '<input name="serial" class="form-control serial-input" type="text" placeholder="Ingrese Serial #"' + numero + '>';
            objTo.appendChild(nuevoDiv)
        }

        $(document).on('blur', '.serial-input', function (event) {
            if (!$(this).val()) {
                $(this).removeClass('is-valid');
                $(this).addClass('is-invalid');
                $(this).attr('placeholder', 'Debe ingresar un serial válido')
            } else {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
            }
            validarInputs();
        });

        function validarInputs() {
            var cant = 0;
            $('.serial-input').each(function (index, item) {
                if ($(item).val()) {
                    cant++;
                }
            });

            if (cant == $("#cantidad").val()) {
                $("#registrarBtn").removeClass('disabled');
            } else {
                $("#registrarBtn").addClass('disabled');
            }
        }
    </script>
    <script>

    </script>
</content>
</body>
</html>