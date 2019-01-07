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
<content tag="content_title">Editar Equipo</content>
<content tag="content">
    <g:form class="needs-validation form" controller="equipo" action="modificarEquipo" method="post" useToken="true">

        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Editar Equipo</h4>

                <input type="hidden" name="idEquipo" value="${equipo.id}"/>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="equipo">Nombre Equipo</label>
                        <input type="text" class="form-control" id="equipo" name="nombre"
                               placeholder="" value="${equipo.nombre}" required>
                        <br>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-12">
                        <label for="equipo">Categoría</label>
                        <select class="select" style="width: 100%" id="categoriaEquipo" name="categoriaEquipo">
                            <option value="${equipo.categoriaEquipo.id}">${equipo.categoriaEquipo.categoria}</option>
                            <g:each in="${CategoriaEquipo.findAllByHabilitado(true)}" var="cat">
                                <option value="${cat.id}">${cat.categoria}</option>
                            </g:each>
                        </select>
                    </div>
                </div>
                <br>
            </div>
        </div>
        <button id="aceptarBtn" class="btn btn-primary" type="submit">Guardar</button>
    </g:form>


</content>
<content tag="js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".select").select2({
                allowClear: true,
                minimumResultsForSearch: 1
            });

        })
    </script>
</content>
</body>
</html>