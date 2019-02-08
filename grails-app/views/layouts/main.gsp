<%@ page import="gestion_equipos_controlados.auth.User; gestion_equipos_controlados.Prestamo" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <asset:link rel="icon" href="images/favicon.png" type="image/x-ico"/>

    <title>
        <g:pageProperty name="page.title"/>
    </title>
    <!-- Custom CSS -->
    <asset:stylesheet src="chartist/dist/chartist.min.css"/>
    <asset:stylesheet src="extra-libs/c3/c3.min.css"/>
    <asset:stylesheet src="morris.js/morris.css"/>
    <!-- Custom CSS -->
    <asset:stylesheet src="dist/css/style.min.css"/>
    <g:pageProperty name="page.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
<!-- ============================================================== -->
<!-- Preloader - style you can find in spinners.css -->
<!-- ============================================================== -->
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>

        <div class="lds-pos"></div>
    </div>
</div>
<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<div id="main-wrapper">
    <!-- ============================================================== -->
    <!-- Topbar header - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <header class="topbar">
        <nav class="navbar top-navbar navbar-expand-md navbar-dark">
            <div class="navbar-header">
                <!-- This is for the sidebar toggle which is visible on mobile only -->
                <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)">
                    <i class="ti-menu ti-close"></i>
                </a>
                <!-- ============================================================== -->
                <!-- Logo -->
                <!-- ============================================================== -->
                <a class="navbar-brand" href="/">
                    <!-- Logo icon -->
                    <b class="logo-icon">
                        <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                        <!-- Dark Logo icon -->
                        <img src="../../assets/images/logo-icon.png" alt="homepage" class="dark-logo"/>

                        <!-- Light Logo icon -->
                        <img src="../../assets/images/logo-light-icon.png" alt="homepage" class="light-logo"/>
                    </b>
                    <!--End Logo icon -->
                    <!-- Logo text -->
                    <span class="logo-text">
                        <!-- dark Logo text -->
                        <img src="../../assets/images/logo-text.png" alt="homepage" class="dark-logo"/>
                        <!-- Light Logo text -->
                        <img src="../../assets/images/logo-light-text.png" class="light-logo" alt="homepage"/>
                    </span>
                </a>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Toggle which is visible on mobile only -->
                <!-- ============================================================== -->
                <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)"
                   data-toggle="collapse" data-target="#navbarSupportedContent"
                   aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="ti-more"></i>
                </a>
            </div>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <div class="navbar-collapse collapse" id="navbarSupportedContent">
                <!-- ============================================================== -->
                <!-- toggle and nav items -->
                <!-- ============================================================== -->
                <ul class="navbar-nav float-left mr-auto">
                    <li class="nav-item d-none d-md-block">
                        <a class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)"
                           data-sidebartype="mini-sidebar">
                            <i class="sl-icon-menu font-20"></i>
                        </a>
                    </li>
                    <!-- ============================================================== -->
                    <!-- Comment -->
                    <!-- ============================================================== -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <i class="ti-bell font-20"></i>
                        </a>

                        <div class="dropdown-menu mailbox animated bounceInDown">
                            <span class="with-arrow">
                                <span class="bg-primary"></span>
                            </span>
                            <ul class="list-style-none">
                                <li>
                                    <div class="drop-title bg-primary text-white">
                                        <h4 class="m-b-0 m-t-5">Préstamos a Vencer</h4>
                                        <span class="font-light">Préstamos que se vencerán en la próxima semana</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="message-center notifications">

                                        <g:each in="${Prestamo.prestamosVenciendo()}"
                                                var="prestamo">
                                            <a href="/prestamo/recibir/?prestamo=${prestamo.id}" class="message-item">
                                                <span class="btn btn-primary btn-circle">
                                                    <i class="ti-user"></i>
                                                </span>

                                                <div class="mail-contnet">
                                                    <h5 class="message-title">${prestamo.nombreEstudiante}</h5>
                                                    <h5 class="mail-desc">${prestamo.matriculaEstudiante}</h5>

                                                    <h2 class="time">${prestamo.fechaEntrega}</h2>
                                                </div>
                                            </a>
                                        </g:each>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!-- ============================================================== -->
                    <!-- End Comment -->
                    <!-- ============================================================== -->
                </ul>
            </div>
        </nav>
    </header>
    <!-- ============================================================== -->
    <!-- End Topbar header -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <aside class="left-sidebar">
        <!-- Sidebar scroll-->
        <div class="scroll-sidebar">
            <!-- Sidebar navigation-->
            <nav class="sidebar-nav">
                <ul id="sidebarnav">
                    <!-- User Profile-->
                    <li>
                        <hr>
                        <!-- User Profile-->
                        <div class="user-profile dropdown m-t-20">
                            <div class="user-content hide-menu m-t-10">
                                <sec:ifLoggedIn>
                                    <h5 class="m-b-10 user-name font-medium">${((User) applicationContext.springSecurityService.getCurrentUser()).username}</h5>

                                    <p class=" m-b-0">${((User) applicationContext.springSecurityService.getCurrentUser()).email}</p>
                                </sec:ifLoggedIn>
                                <br>
                                <a href="/logout" title="Logout" class="btn btn-circle btn-sm">
                                    <i class="ti-power-off"></i>
                                </a>
                            </div>
                        </div>
                        <!-- End User Profile-->
                    </li>
                    <!-- User Profile-->
                    <hr>
                    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_GESTIONAR_PRESTAMO">
                        <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark"
                                                    href="javascript:void(0)" aria-expanded="false"><i
                                    class="icon-Car-Wheel"></i><span class="hide-menu">Prestamos</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="/prestamo/crear" class="sidebar-link"><i
                                        class="mdi mdi-adjust"></i><span class="hide-menu">Nuevo Prestamo</span></a>
                                </li>
                                <li class="sidebar-item"><a href="/prestamo/index" class="sidebar-link"><i
                                        class="mdi mdi-adjust"></i><span class="hide-menu">Prestamos Activos</span></a>
                                </li>
                                <li class="sidebar-item"><a href="/prestamo/historial" class="sidebar-link"><i
                                        class="mdi mdi-adjust"></i><span class="hide-menu">Historial Prestamos</span>
                                </a>
                                </li>
                            </ul>
                        </li>
                    </sec:ifAnyGranted>




                    <li class="sidebar-item">
                        <a class="sidebar-link has-arrow waves-effect waves-dark"
                           href="javascript:void(0)" aria-expanded="false">
                            <i class="icon-Increase-Inedit"></i><span class="hide-menu">Gestión</span>
                        </a>

                        <ul aria-expanded="false" class="collapse first-level">
                            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_GESTIONAR_MOVIMIENTO">
                                <li class="sidebar-item">
                                    <a class="has-arrow sidebar-link" href="javascript:void(0)" aria-expanded="false">
                                        <i class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Movimientos</span>
                                    </a>
                                    <ul aria-expanded="false" class="collapse second-level">
                                        <li class="sidebar-item">
                                            <a href="/movimiento/index" class="sidebar-link">
                                                <i class="mdi mdi-octagram"></i>
                                                <span class="hide-menu">Movimientos Hechos</span>
                                            </a>
                                        </li>
                                        <li class="sidebar-item"><a href="/movimiento/crearEntrada"
                                                                    class="sidebar-link"><i
                                                    class="mdi mdi-octagram"></i><span
                                                    class="hide-menu">Registrar Entrada</span></a>
                                        </li>
                                        <li class="sidebar-item"><a href="/movimiento/crearSalida"
                                                                    class="sidebar-link"><i
                                                    class="mdi mdi-octagram"></i><span
                                                    class="hide-menu">Registrar Salida</span></a>
                                        </li>
                                    </ul>
                                </li>
                            </sec:ifAnyGranted>

                            <li class="sidebar-item"><a class="has-arrow sidebar-link" href="javascript:void(0)"
                                                        aria-expanded="false"><i
                                        class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Equipos</span></a>
                                <ul aria-expanded="false" class="collapse second-level">
                                    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_GESTIONAR_EQUIPO">
                                        <li class="sidebar-item"><a href="/equipo/index" class="sidebar-link"><i
                                                class="mdi mdi-octagram"></i><span class="hide-menu">Ver Equipos</span>
                                        </a>
                                        </li>
                                        <li class="sidebar-item"><a href="/equipo/crear" class="sidebar-link"><i
                                                class="mdi mdi-octagram"></i><span class="hide-menu">Crear Equipo</span>
                                        </a>
                                        </li>
                                    </sec:ifAnyGranted>

                                    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_GESTIONAR_CATEGORIA_EQUIPO">
                                        <li class="sidebar-item"><a href="/categoriaEquipo/index"
                                                                    class="sidebar-link"><i
                                                    class="mdi mdi-octagram"></i><span
                                                    class="hide-menu">Categorías Equipos</span></a>
                                        </li>
                                    </sec:ifAnyGranted>
                                </ul>
                            </li>

                            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_GESTIONAR_USUARIO">
                                <li class="sidebar-item"><a class="has-arrow sidebar-link" href="javascript:void(0)"
                                                            aria-expanded="false"><i
                                            class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Usuarios</span>
                                </a>
                                    <ul aria-expanded="false" class="collapse second-level">
                                        <li class="sidebar-item"><a href="/usuario/index" class="sidebar-link"><i
                                                class="mdi mdi-octagram"></i><span
                                                class="hide-menu">Ver Usuarios</span></a>
                                        </li>
                                        <li class="sidebar-item"><a href="/usuario/crear" class="sidebar-link"><i
                                                class="mdi mdi-octagram"></i><span
                                                class="hide-menu">Crear Usuario</span></a>
                                        </li>
                                    </ul>
                                </li>
                            </sec:ifAnyGranted>
                        </ul>
                    </li>
                </ul>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
    </aside>
    <!-- ============================================================== -->
    <!-- End Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Page wrapper  -->
    <!-- ============================================================== -->
    <div class="page-wrapper">

        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-5 align-self-center">
                    <h4 class="page-title">
                        <g:pageProperty name="page.content_title"/>
                    </h4>

                    <div class="d-flex align-items-center">
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <g:pageProperty name="page.content"/>
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
        <footer class="footer text-center">
            %{--All Rights Reserved by AdminBite admin. Designed and Developed by
            <a href="https://wrappixel.com">WrapPixel</a>.--}%
        </footer>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- customizer Panel -->
<!-- ============================================================== -->

<div class="chat-windows"></div>
<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
<asset:javascript src="jquery/dist/jquery.min.js"/>
<!-- Bootstrap tether Core JavaScript -->
<asset:javascript src="popper.js/dist/umd/popper.min.js"/>
<asset:javascript src="bootstrap/dist/js/bootstrap.min.js"/>
<!-- apps -->
<asset:javascript src="dist/js/app.min.js"/>
<asset:javascript src="dist/js/app.init.js"/>
<asset:javascript src="dist/js/app-style-switcher.js"/>
<!-- slimscrollbar scrollbar JavaScript -->
<asset:javascript src="perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"/>
<asset:javascript src="sparkline/sparkline.js"/>
<!--Wave Effects -->
<asset:javascript src="dist/js/waves.js"/>
<!--Menu sidebar -->
<asset:javascript src="dist/js/sidebarmenu.js"/>
<!--Custom JavaScript -->
<asset:javascript src="dist/js/custom.min.js"/>
<!--This page JavaScript -->
<!--chartis chart-->
<asset:javascript src="chartist/dist/chartist.min.js"/>
<asset:javascript src="chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"/>
<!--c3 charts -->
<asset:javascript src="c3/d3.min.js"/>
<asset:javascript src="c3/c3.min.js"/>
<!--chartjs -->
<asset:javascript src="raphael/raphael.min.js"/>
<asset:javascript src="morris.js/morris.min.js"/>

<asset:javascript src="dist/js/pages/dashboards/dashboard1.js"/>

<g:pageProperty name="page.js"/>

</body>

</html>