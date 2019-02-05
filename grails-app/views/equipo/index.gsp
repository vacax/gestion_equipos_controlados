<%@ page import="gestion_equipos_controlados.CategoriaEquipo; gestion_equipos_controlados.Equipo; gestion_equipos_controlados.CategoriaEquipo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Equipos</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">Equipos</content>
<content tag="content">

    <div class="row">
        <div class="col-md-12">
            <a class="btn btn-info" href="/equipo/crear">Crear Equipo</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Lista de Equipos</h4>
                    <h5 class="card-subtitle">Listado de todos los equipos</h5>
                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Categoría</th>
                                <th class="border-top-0">Cant Disponible</th>
                                <th class="border-top-0">Cant Total</th>
                                <th class="border-top-0">Serial</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                            <g:each in="${Equipo.list()}" var="equipo">
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="">
                                            <h4 class="m-b-0 font-16">${equipo.nombre}</h4>
                                        </div>
                                    </div>
                                </td>
                                <td>${equipo.categoriaEquipo.categoria}</td>
                                <td>${equipo.cantidadDisponible}</td>
                                <td>${equipo.cantidadTotal}</td>
                                <td><g:if test="${equipo.serial}">
                                    Si
                                </g:if>
                                    <g:else>
                                        No
                                    </g:else></td>
                                <td><g:if test="${equipo.habilitado}">
                                    <label class="label label-success">Habilitado</label>
                                </g:if>
                                    <g:else>
                                        <label class="label label-danger">Deshabilitado</label>
                                    </g:else></td>
                                <td><g:link class="btn btn-info" controller="equipo" action="edit" id="${equipo.id}">Editar</g:link></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Categoría</th>
                                <th class="border-top-0">Cant Disponible</th>
                                <th class="border-top-0">Cant Total</th>
                                <th class="border-top-0">Serial</th>
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