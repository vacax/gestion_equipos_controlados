<%@ page import="gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <title></title>
    <content tag="title">Equipos</content>
    <content tag="css">
        <asset:stylesheet src="select2/dist/css/select2.min.css"/>
    </content>
</head>

<body>
<content tag="content_title">Crear Equipo</content>
<content tag="content">
    <g:form class="needs-validation form" controller="equipo" action="save" method="post">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nuevo equipo</h4>
                <g:hasErrors>
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </g:hasErrors>
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
                        <label for="equipo">Categoría</label>
                        <select class="select" style="width: 100%" id="categoriaEquipo" name="categoriaEquipo">
                            <option></option>
                            <g:each in="${CategoriaEquipo.findAllByHabilitado(true)}" var="cat">
                                <option value="${cat.id}">${cat.categoria}</option>
                            </g:each>
                        </select>

                        <div id="categoria-valido" style="color: red; display: none;">
                            * Debe selecciona una categoría.
                        </div>
                        <br>
                    </div>
                </div>
                <br>

                <div class="form-row">
                    <div class="col-md-12">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="serial" name="serial">
                            <label class="custom-control-label" for="serial">Necesita Serial</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </g:form>
    <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>

</content>
<content tag="js">
    <asset:javascript src="select2/dist/js/select2.full.min.js"/>
    <asset:javascript src="select2/dist/js/select2.min.js"/>
    <asset:javascript src="dist/js/pages/forms/select2/select2.init.js"/>
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
                if (equipo) {
                    $.ajax({
                        url: "/equipo/verificarNombreEquipo/",
                        data: {data: equipo},
                        success: function (data) {
                            if (data === 'false') {
                                $("#nombre-valido").css('display', 'none');
                                if ($("#categoriaEquipo").val().length > 0) {
                                    $("#categoria-valido").css('display', 'none');
                                    $(".form").submit();
                                } else {
                                    $("#categoria-valido").css('display', 'block')
                                }

                            } else {
                                $("#nombre-valido").css('display', 'block');
                            }
                        }
                    });
                } else {
                    $("#nombre-valido").css('display', 'block');
                }
            }
        });

    })
</script>
    <script type="text/javascript">
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