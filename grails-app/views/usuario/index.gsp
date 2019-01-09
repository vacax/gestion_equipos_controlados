<%@ page import="gestion_equipos_controlados.auth.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Usuarios</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>

<body>
<content tag="content_title">Usuarios</content>
<content tag="content">
    <div class="row">
        <div class="col-md-12">
            <a class="btn btn-info" href="/usuario/crear">Crear Usuario</a>
        </div>
    </div>
    <br>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Lista de Usuarios</h4>
                    <h5 class="card-subtitle">Listado de todos los usuarios</h5>

                    <div class="table-responsive">
                        <table id="zero_config" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="border-top-0">Username</th>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Correo Electrónico</th>
                                <th class="border-top-0">Habilitado</th>
                                <th class="border-top-0">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${User.list()}" var="user">
                                <tr>
                                    <td>${user.username}</td>
                                    <td>${user.name}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <g:if test="${user.enabled}">
                                            <label class="label label-success">Habilitado</label>
                                        </g:if>
                                        <g:else>
                                            <label class="label label-danger">Deshabilitado</label>
                                        </g:else>
                                    </td>
                                    <td><a class="btn btn-info" href="/usuario/editar/${user.id}">Editar</a></td>
                                </tr>
                            </g:each>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th class="border-top-0">Username</th>
                                <th class="border-top-0">Nombre</th>
                                <th class="border-top-0">Correo Electrónico</th>
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