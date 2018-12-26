<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Categorias Equipos</content>
</head>

<body>
<content tag="content_title">Crear Categoría</content>
<content tag="content">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Creando nueva categoría</h4>
                <g:form class="needs-validation form" controller="categoriaEquipo" action="save" method="post">
                    <div class="form-row">

                        <div class="col-md-12">
                            <input value="${categoria.id}" name="id" id="id" hidden/>
                        </div>

                        <div class="col-md-12">
                            <label for="categoria">Nombre Categoría</label>
                            <input type="text" class="form-control" id="categoria" name="categoria"
                                   placeholder="Nombre Categoría" value="${categoria.categoria}" required disabled>
                            <br>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="habilitado"
                                           name="habilitado" <g:if
                                                   test="${categoria.habilitado}">checked</g:if>/>
                                    <label class="custom-control-label" for="habilitado">Habilitado</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button id="aceptarBtn" class="btn btn-primary">Aceptar</button>
                </g:form>
            </div>
        </div>
    </div>
</content>
<content tag="js">
    <script type="text/javascript">
        $(document).ready(function () {
            /*$("#aceptarBtn").on('click', function (event) {
                var categoria = $("#categoria").val();
                $.ajax({
                    url: "/categoriaEquipo/verificarCategoriaDisponible/",
                    data: {data: categoria},
                    success: function (data) {
                        if (data === 'false') {
                            $("#nombre-valido").css('display', 'none');
                            $(".form").submit();
                        } else {
                            $("#nombre-valido").css('display', 'block');
                        }
                    }
                });
            })*/
        })
    </script>
</content>
</body>
</html>