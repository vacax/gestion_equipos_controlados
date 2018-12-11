<%@ page import="gestion_equipos_controlados.Movimiento" %>
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
                <h4 class="card-title">Nuevo Movimiento</h4>
                <g:form class="needs-validation form" controller="movimiento" action="save" method="post">
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
                    </div>
                    <br>
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="tipoMovimiento">Tipo de Movimiento</label>
                            <select class="selectes" style="width: 100%" id="tipoMovimiento" name="tipoMovimiento">
                                <option></option>
                                <option value="${Movimiento.TipoMovimiento.ENTRADA}">${Movimiento.TipoMovimiento.ENTRADA}</option>
                                <option value="${Movimiento.TipoMovimiento.SALIDA}">${Movimiento.TipoMovimiento.SALIDA}</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="cantidad">Cantidad</label>
                            <input type="number" min="0" class="form-control" id="cantidad" name="cantidad"
                                   placeholder="Cantidad" value="" required>
                        </div>
                    </div>
                    <br>
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

            $(".selectes").select2({
                placeholder: "Seleccione Tipo Movimiento",
                allowClear: true,
                minimumResultsForSearch: 1
            });
        })
    </script>
</content>
</body>
</html>