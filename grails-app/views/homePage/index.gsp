<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" name="layout" content="main"/>
    <content tag="title">Inicio</content>
    <content tag="css">
        <asset:stylesheet src="datatables.net-bs4/css/dataTables.bootstrap4.css"/>
    </content>
</head>
<body>
<content tag="content_title">Gestión de Equipos Controlados - ECT - PUCMM</content>
    <content tag="content">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-subtitle">Cantidad de Equipos Prestados</h5>
                            <div class="table-responsive">
                                    <table id="zero_config" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Equipo</th>
                                            <th>Prestados</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                        <g:each in="${listadoEquipos}" var="equipo">
                                            <td>${equipo.nombre}</td>
                                            <td>${equipo.cantidadTotal - equipo.cantidadDisponible}</td>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-subtitle">Prestamos Vencidos</h5>
                            <div class="table-responsive">
                                <table id="zero_configure" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Estudiante</th>
                                        <th>Accion</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                    <g:each in="${prestamosVencidos}" var="prestamo">
                                        <td>${prestamo.nombreEstudiante}</td>
                                        <td><g:link class="btn btn-info" controller="prestamo" action="recibir" id="${prestamo.id}">Ver</g:link></td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </content>
</body>
</html>
