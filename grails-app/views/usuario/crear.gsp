<%@ page import="gestion_equipos_controlados.auth.Role" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Crear Usuario</content>
    <content tag="css">
        <asset:stylesheet src="select2/dist/css/select2.min.css"/>
    </content>
</head>

<body>
<content tag="page-title">Crear Usuario</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nuevo usuario</h4>
                <g:hasErrors>
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </g:hasErrors>
                <g:form class="needs-validation form" controller="usuario" action="save" method="post">
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Username" value="" required>

                            <div id="username-valido" style="color: red; display: none;">
                                * Username no disponible o no válido.
                            </div>
                            <br>
                        </div>

                        <div class="col-md-6">
                            <label for="name">Nombre Usuario</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="Nombre Usuario" value="" required>

                            <div id="nombre-valido" style="color: red; display: none;">
                                * Nombre no disponible!
                            </div>
                            <br>
                        </div>

                    </div>

                    <div class="form-row">
                        <div class="col-md-12">
                            <label for="email">Correo Electrónico</label>
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="Correo Electrónico" value="" required>

                            <div id="email-valido" style="color: red; display: none;">
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

                            <div id="pass-valido" style="color: red; display: none;">
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
                            <select id="roles" name="roles" multiple="multiple" style="width: 100%" required>
                                <g:each in="${Role.list()}" var="rol">
                                    <option value="${rol.id}">${rol.authority}</option>
                                </g:each>
                            </select>

                            <div id="roles-valido" style="color: red; display: none;">
                                * Debe seleccionar al menos un rol.
                            </div>
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
    <asset:javascript src="select2/dist/js/select2.full.min.js"/>
    <asset:javascript src="select2/dist/js/select2.min.js"/>
    <asset:javascript src="dist/js/pages/forms/select2/select2.init.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#roles").select2({
                    placeholder: 'Seleccione al menos un rol'
                }
            );

            $("#aceptarBtn").on('click', function (event) {
                if ($("#password").val() && $("#password").val() === $("#verify-pass").val()) {
                    $("#pass-valido").css('display', 'none');
                    var username = $("#username").val();
                    if (username) {
                        $.ajax({
                            url: "/usuario/verificarUsernameDisponible/",
                            data: {data: username},
                            success: function (data) {
                                if (data === 'true') {
                                    $("#username-valido").css('display', 'none');
                                    var nombre = $("#name").val();
                                    var correo = $("#email").val();
                                    if (nombre) {
                                        $("#nombre-valido").css('display', 'none');
                                        if (correo) {
                                            $("#email-valido").css('display', 'none');
                                            if ($('#roles').val().length > 0) {
                                                $("#roles-valido").css('display', 'none');
                                                $(".form").submit();
                                            } else {
                                                $("#roles-valido").css('display', 'block')
                                            }
                                        } else {
                                            $("#email-valido").css('display', 'block')
                                        }
                                    } else {
                                        $("#nombre-valido").css('display', 'block')
                                    }
                                } else {
                                    $("#username-valido").css('display', 'block');
                                }
                            }
                        });
                    } else {
                        $("#username-valido").css('display', 'block');
                    }
                } else {
                    $("#pass-valido").css('display', 'block');
                }
            });
        })
    </script>
</content>
</body>
</html>