<%@ page import="gestion_equipos_controlados.auth.Role" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Editando Usuarios</content>
    <content tag="css">
        <asset:stylesheet src="select2/dist/css/select2.min.css"/>
    </content>
</head>

<body>
<content tag="content_title">Editar Usuario</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Editando usuario ${user.username}</h4>
                <g:hasErrors>
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </g:hasErrors>
                <g:form class="needs-validation form" controller="usuario" action="update" method="post">
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="id_user" name="id_user"
                                   placeholder="ID" value="${user.id}" hidden>
                            <input type="text" class="form-control" id="old_username" name="old_username"
                                   placeholder="Username" value="${user.username}" hidden>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Username" value="${user.username}" required>

                            <div id="username-valido" style="color: #ffc025; display: none;">
                                * Username no disponible!
                            </div>
                            <br>
                        </div>

                        <div class="col-md-6">
                            <label for="name">Nombre Usuario</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="Nombre Usuario" value="${user.name}" required>

                            <div id="nombre-valido" style="color: #ffc025; display: none;">
                                * Nombre no disponible!
                            </div>
                            <br>
                        </div>

                    </div>

                    <div class="form-row">
                        <div class="col-md-12">
                            <label for="email">Correo Electrónico</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="Correo Electrónico" value="${user.email}" required>

                            <div id="email-valido" style="color: #ffc025; display: none;">
                                * Correo no disponible!
                            </div>
                            <br>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="password">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Contraseña" value="" required>

                            <div id="pass-valido" style="color: #ffc025; display: none;">
                                * Las contraseñas no son las mismas!
                            </div>
                            <br>
                        </div>

                        <div class="col-md-6">
                            <label for="verify-pass">Confirmar Contraseña</label>
                            <input type="password" class="form-control" id="verify-pass" name="verify-pass"
                                   placeholder="Confirmar Contraseña" value="" required>
                            <br>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-12">
                            <label for="roles">Rol</label>
                            <select id="roles" name="roles" multiple="multiple" class="form-control">
                                <g:each in="${Role.list()}" var="role">
                                    <option value="${role.id}"
                                        <g:each in="${user.getAuthorities()}" var="auth">
                                            <g:if test="${role.authority == auth.authority}">selected</g:if>
                                        </g:each>>
                                        ${role.authority}
                                    </option>
                                </g:each>
                            </select>
                        </div>
                    </div>
                    <br>

                    <div class="form-row">
                        <div class="col-md-12">
                            <label for="enabled">Habilitado</label>
                        <input id="enabled" name="enabled" type="checkbox" <g:if test="${user.enabled}">checked ></g:if>
                        </div>
                    </div>

                </g:form>
                <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>
            </div>
        </div>
    </div>
</content>
<content tag="js">
    <asset:javascript src="select2/dist/js/select2.full.min.js"/>
    <asset:javascript src="select2/dist/js/select2.min.js"/>
    <asset:javascript src="dist/js/pages/forms/select2/select2.init.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#roles").select2({
                    placeholder: 'Seleccione al menos un rol',
                }
            );
            $("#aceptarBtn").on('click', function (event) {

                if ($("#password").val() === $("#verify-pass").val()) {
                    $("#pass-valido").css('display', 'none');
                    var username = $("#username").val();
                    $.ajax({
                        url: "/usuario/verificarUsernameEditadoDisponible/",
                        data: {newUsername: username, id: $("#id_user").val()},
                        success: function (data) {
                            if (data === 'true') {
                                $("#username-valido").css('display', 'none');
                                $(".form").submit();
                            } else {
                                $("#username-valido").css('display', 'block');
                            }
                        }
                    });
                } else {
                    $("#pass-valido").css('display', 'block');
                }
            });
        })
    </script>
</content>
</body>
</html>