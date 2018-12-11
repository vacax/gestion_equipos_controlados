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
                                    <option value="${equipo}">${equipo.nombre}</option>
                                </g:each>
                            </select>
                        </div>
                    </div>
                    <br>

                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="cantidad">Cantidad</label>
                            <input type="number" min="0" step="1" class="form-control" id="cantidad" name="cantidad"
                                   placeholder="Cantidad" value="0" required>
                        </div>
                    </div>
                    <br>
                    <div class="col-md-1">
                        <div class="form-group">
                            <input type="hidden" id="idequipo" name="idequipo" type="text">
                            <input type="hidden" id="serialEquipo" name="serialEquipo" type="text">
                            <input type="hidden" id="items" name="items" >
                        </div>
                    </div>
                    <g:link action="save">
                        <button id="aceptarBtn" class="btn btn-primary" type="submit">Registrar</button>
                    </g:link>
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

            $("#equipo").on('change', function () {
                var equipo = $(this).val();
                alert(equipo);
            })

        })
    </script>
    <script>

    </script>
</content>
</body>
</html>