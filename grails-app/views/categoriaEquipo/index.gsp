<%@ page import="gestion_equipos_controlados.CategoriaEquipo; gestion_equipos_controlados.Equipo; gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Categorias Equipos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">Categorías de Equipos</content>
<content tag="content">

    <div class="row">
        <div class="col-md-12">
            <a class="btn btn-info" href="/categoriaEquipo/crear">Crear Categoría</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Lista de Categorías de Equipos</h4>
                    <h5 class="card-subtitle">Listado de todas las categorías de equipos comprendidas</h5>
                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Cantidad de Equipos</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${CategoriaEquipo.list()}" var="categoria">
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="">
                                            <h4 class="m-b-0 font-16">${categoria.categoria}</h4>
                                        </div>
                                    </div>
                                </td>
                                <td>${Equipo.findAllByCategoriaEquipo(categoria).size()}</td>
                                <td><g:if test="${categoria.habilitado}">
                                    <label class="label label-success">Habilitado</label>
                                </g:if>
                                    <g:else>
                                        <label class="label label-danger">Deshabilitado</label>
                                    </g:else></td>
                                <td><a class="btn btn-info" href="#">Editar</a></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Cantidad de Equipos</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</content>
<content tag="js">
    <!--This page plugins -->
    <asset:javascript src="DataTables/datatables.min.js"/>
    <asset:javascript src="dist/js/pages/datatable/datatable-basic.init.js"/>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").DataTable();
        })
    </script>
</content>
</body>
</html>