<%@ page import="gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <title></title>
    <content tag="title">Categorias Equipos</content>
    <content tag="css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet"/>
    </content>
</head>

<body>
<content tag="content_title">Crear Equipo</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nueva categoría</h4>
                <g:form class="needs-validation form" controller="equipo" action="save" method="post">
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
                        <div class="col-md-6">
                            <label for="cantidadDisponible">Cantidad Disponible</label>
                            <input type="number" min="0" class="form-control" id="cantidadDisponible" name="cantidadDisponible"
                                   placeholder="Cantidad Disponible" value="" required>

                            <div id="cantidad-valido" style="color: red; display: none;">
                                * No disponible!
                            </div>
                            <br>
                        </div>

                        <div class="col-md-6">
                            <label for="cantidadTotal">Cantidad Total</label>
                            <input type="number" min="0" class="form-control" id="cantidadTotal" name="cantidadTotal"
                                   placeholder="Cantidad Total" value="" required>

                            <div id="cantidadTotal-valido" style="color: red; display: none;">
                                * No disponible!
                            </div>
                            <br>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="checkbox checkbox-success">
                            <label for="serial"> Serial </label>
                            <input id="serial" type="checkbox" name="serial">
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

                </g:form>
                <br>
                <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>
            </div>
        </div>
    </div>
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
            })
        })
    </script>
</content>
</body>
</html>