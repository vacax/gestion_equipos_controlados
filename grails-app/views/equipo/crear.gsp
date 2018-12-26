<%@ page import="gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <title></title>
    <content tag="title">Equipos</content>
    <content tag="css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet"/>
    </content>
</head>

<body>
<content tag="content_title">Crear Equipo</content>
<content tag="content">
    <g:form class="needs-validation form" controller="equipo" action="save" method="post">

        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nuevo equipo</h4>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="equipo">Nombre Equipo</label>
                        <input type="text" class="form-control" id="equipo" name="nombre"
                               placeholder="Nombre Equipo" value="" required>

                        <div id="nombre-valido" style="color: red; display: none;">
                            * No disponible!
                        </div>
                        <br>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="cantidadTotal">Cantidad</label>
                        <input type="number" min="0" class="form-control" id="cantidadTotal" name="cantidadTotal"
                               placeholder="Cantidad" value="" required>

                        <div id="cantidad-valido" style="color: red; display: none;">
                            * No disponible!
                        </div>
                        <br>
                    </div>
                </div>

                <div class="form-group">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="serial" name="serial">
                        <label class="custom-control-label" for="serial">Necesita Serial</label>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="equipo">Categoría</label>
                        <select class="select" style="width: 100%" id="categoriaEquipo" name="categoriaEquipo">
                            <option></option>
                            <g:each in="${CategoriaEquipo.findAllByHabilitado(true)}" var="cat">
                                <option value="${cat.id}">${cat.categoria}</option>
                            </g:each>
                        </select>
                    </div>
                </div>
                <br>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-12">
                <div class="card" id="divSerial" style="display: none">
                    <div class="card-body">
                        <h4 class="card-title">Seriales</h4>

                        <div id="camposSeriales" class=""></div>
                    </div>
                </div>
            </div>
        </div>
    </g:form>
    <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>

</content>
<content tag="js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".select").select2({
                placeholder: "Seleccione una categoría",
                allowClear: true,
                minimumResultsForSearch: 1
            });

            $("#aceptarBtn").on('click', function (event) {
                if ($(this).hasClass('disabled')) {
                    event.preventDefault();
                } else {
                    var equipo = $("#equipo").val();
                    $.ajax({
                        url: "/equipo/verificarNombreEquipo/",
                        data: {data: equipo},
                        success: function (data) {
                            if (data === 'false') {
                                $("#nombre-valido").css('display', 'none');
                                $(".form").submit();
                            } else {
                                $("#nombre-valido").css('display', 'block');
                            }
                        }
                    });
                }
            })

            $("#serial").change(function (event) {
                if (this.checked) {
                    $("#aceptarBtn").addClass('disabled');
                } else {
                    $("#aceptarBtn").removeClass('disabled');
                }
            })

        })
    </script>
    <script type="text/javascript">

        var numero = 0;

        $("#serial").change(function (event) {
            if (this.checked) {
                for (var i = 0; i < $("#cantidadTotal").val(); i++) {
                    agregarCampoSerial();
                    $("#divSerial").css('display', 'block');
                }
            } else {
                $("#camposSeriales").empty();
                $("#divSerial").css('display', 'none');
            }
        });

        function agregarCampoSerial() {
            numero++;
            var objTo = document.getElementById('camposSeriales');
            var nuevoDiv = document.createElement("div");
            nuevoDiv.setAttribute("class", "form-group serial-div");
            nuevoDiv.innerHTML = '<input name="serialEquipo" class="form-control serial-input" type="text" placeholder="Ingrese Serial #"' + numero + '>';
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

            if (cant == $("#cantidadTotal").val()) {
                $("#aceptarBtn").removeClass('disabled');
            } else {
                $("#aceptarBtn").addClass('disabled');
            }
        }


        $("#cantidadTotal").on('change', function (event) {
            if ($("#serial").prop('checked', true)) {
                $("#camposSeriales").empty();
                for (var i = 0; i < $("#cantidadTotal").val(); i++) {
                    agregarCampoSerial();
                    $("#divSerial").css('display', 'block');
                }
            }
        })
    </script>
</content>
</body>
</html>