<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Categorias Equipos</content>
</head>

<body>
<content tag="content_title">Crear Usuario</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nuevo usuario</h4>
                <g:form class="needs-validation form" controller="usuario" action="save" method="post">
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Username" value="" required>

                            <div id="username-valido" style="color: red; display: none;">
                                * Username no disponible!
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
                            <label for="email">Username</label>
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
                </g:form>
                <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>
            </div>
        </div>
    </div>
</content>
<content tag="js">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#aceptarBtn").on('click', function (event) {

                if ($("#password").val() === $("#verify-pass").val()) {
                    $("#pass-valido").css('display', 'none');
                    var username = $("#username").val();
                    $.ajax({
                        url: "/usuario/verificarUsernameDisponible/",
                        data: {data: username},
                        success: function (data) {
                            if (data === 'false') {
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