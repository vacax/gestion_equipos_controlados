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
                <a class="navbar-brand" href="index.html">
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
                                        <h4 class="m-b-0 m-t-5">4 New</h4>
                                        <span class="font-light">Notifications</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="message-center notifications">
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="btn btn-danger btn-circle">
                                                <i class="fa fa-link"></i>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Luanch Admin</h5>
                                                <span class="mail-desc">Just see the my new admin!</span>
                                                <span class="time">9:30 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="btn btn-success btn-circle">
                                                <i class="ti-calendar"></i>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Event today</h5>
                                                <span class="mail-desc">Just a reminder that you have event</span>
                                                <span class="time">9:10 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="btn btn-info btn-circle">
                                                <i class="ti-settings"></i>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Settings</h5>
                                                <span class="mail-desc">You can customize this template as you want</span>
                                                <span class="time">9:08 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="btn btn-primary btn-circle">
                                                <i class="ti-user"></i>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Pavan kumar</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:02 AM</span>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                                <li>
                                    <a class="nav-link text-center m-b-5" href="javascript:void(0);">
                                        <strong>Check all notifications</strong>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!-- ============================================================== -->
                    <!-- End Comment -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Messages -->
                    <!-- ============================================================== -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" id="2"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="font-20 ti-email"></i>

                        </a>

                        <div class="dropdown-menu mailbox animated bounceInDown" aria-labelledby="2">
                            <span class="with-arrow">
                                <span class="bg-danger"></span>
                            </span>
                            <ul class="list-style-none">
                                <li>
                                    <div class="drop-title bg-danger text-white">
                                        <h4 class="m-b-0 m-t-5">5 New</h4>
                                        <span class="font-light">Messages</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="message-center message-body">
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="user-img">
                                                <img src="../../assets/images/users/1.jpg" alt="user"
                                                     class="rounded-circle">
                                                <span class="profile-status online pull-right"></span>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Pavan kumar</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:30 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="user-img">
                                                <img src="../../assets/images/users/2.jpg" alt="user"
                                                     class="rounded-circle">
                                                <span class="profile-status busy pull-right"></span>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Sonu Nigam</h5>
                                                <span class="mail-desc">I've sung a song! See you at</span>
                                                <span class="time">9:10 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="user-img">
                                                <img src="../../assets/images/users/3.jpg" alt="user"
                                                     class="rounded-circle">
                                                <span class="profile-status away pull-right"></span>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Arijit Sinh</h5>
                                                <span class="mail-desc">I am a singer!</span>
                                                <span class="time">9:08 AM</span>
                                            </div>
                                        </a>
                                        <!-- Message -->
                                        <a href="javascript:void(0)" class="message-item">
                                            <span class="user-img">
                                                <img src="../../assets/images/users/4.jpg" alt="user"
                                                     class="rounded-circle">
                                                <span class="profile-status offline pull-right"></span>
                                            </span>

                                            <div class="mail-contnet">
                                                <h5 class="message-title">Pavan kumar</h5>
                                                <span class="mail-desc">Just see the my admin!</span>
                                                <span class="time">9:02 AM</span>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                                <li>
                                    <a class="nav-link text-center link" href="javascript:void(0);">
                                        <b>See all e-Mails</b>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!-- ============================================================== -->
                    <!-- End Messages -->
                    <!-- ============================================================== -->
                </ul>
                <!-- ============================================================== -->
                <!-- Right side toggle and nav items -->
                <!-- ============================================================== -->
                <ul class="navbar-nav float-right">
                    <!-- ============================================================== -->
                    <!-- User profile and search -->
                    <!-- ============================================================== -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic" href=""
                           data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            <img src="../../assets/images/users/1.jpg" alt="user" class="rounded-circle" width="31">
                        </a>

                        <div class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
                            <span class="with-arrow">
                                <span class="bg-primary"></span>
                            </span>

                            <div class="d-flex no-block align-items-center p-15 bg-primary text-white m-b-10">
                                <div class="">
                                </div>

                                <div class="m-l-10">
                                    <h4 class="m-b-0">Steave Jobs</h4>

                                    <p class=" m-b-0">varun@gmail.com</p>
                                </div>
                            </div>
                            <a class="dropdown-item" href="javascript:void(0)">
                                <i class="ti-user m-r-5 m-l-5"></i> Mi Perfil</a>

                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="javascript:void(0)">
                                <i class="fa fa-power-off m-r-5 m-l-5"></i> Logout</a>

                            <div class="dropdown-divider"></div>
                        </div>
                    </li>
                    <!-- ============================================================== -->
                    <!-- User profile and search -->
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
                    <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark"
                                                href="javascript:void(0)" aria-expanded="false"><i
                                class="icon-Car-Wheel"></i><span class="hide-menu">Prestamos</span></a>
                        <ul aria-expanded="false" class="collapse  first-level">
                            <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><i
                                    class="mdi mdi-adjust"></i><span class="hide-menu">Nuevo Prestamo</span></a></li>
                            <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><i
                                    class="mdi mdi-adjust"></i><span class="hide-menu">Prestamos Activos</span></a></li>
                            <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><i
                                    class="mdi mdi-adjust"></i><span class="hide-menu">Historial Prestamos</span></a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-item"><a class="sidebar-link has-arrow waves-effect waves-dark"
                                                href="javascript:void(0)" aria-expanded="false"><i
                                class="icon-Increase-Inedit"></i><span class="hide-menu">Gestión</span></a>
                        <ul aria-expanded="false" class="collapse first-level">
                            <li class="sidebar-item"><a class="has-arrow sidebar-link" href="javascript:void(0)"
                                                        aria-expanded="false"><i
                                        class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Movimientos</span>
                            </a>
                                <ul aria-expanded="false" class="collapse second-level">
                                    <li class="sidebar-item"><a href="/movimiento/index" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span class="hide-menu">Movimientos Hechos</span>
                                    </a>
                                    </li>
                                    <li class="sidebar-item"><a href="/movimiento/crearEntrada" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span
                                            class="hide-menu">Registrar Entrada</span></a>
                                    </li>
                                    <li class="sidebar-item"><a href="/movimiento/crearSalida" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span
                                            class="hide-menu">Registrar Salida</span></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="sidebar-item"><a class="has-arrow sidebar-link" href="javascript:void(0)"
                                                        aria-expanded="false"><i
                                        class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Equipos</span></a>
                                <ul aria-expanded="false" class="collapse second-level">
                                    <li class="sidebar-item"><a href="/equipo/index" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span class="hide-menu">Ver Equipos</span></a>
                                    </li>
                                    <li class="sidebar-item"><a href="/equipo/crear" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span class="hide-menu">Crear Equipo</span></a>
                                    </li>
                                    <li class="sidebar-item"><a href="/categoriaEquipo/index" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span
                                            class="hide-menu">Categorías Equipos</span></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="sidebar-item"><a class="has-arrow sidebar-link" href="javascript:void(0)"
                                                        aria-expanded="false"><i
                                        class="mdi mdi-playlist-plus"></i> <span class="hide-menu">Prestamos</span></a>
                                <ul aria-expanded="false" class="collapse second-level">
                                    <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><i
                                            class="mdi mdi-octagram"></i><span class="hide-menu">Estados Prestamos</span></a>
                                    </li>
                                </ul>
                            </li>
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
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
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
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
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
            All Rights Reserved by AdminBite admin. Designed and Developed by
            <a href="https://wrappixel.com">WrapPixel</a>.
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
<asset:javascript src="dist/js/app.init.horizontal.js"/>
<asset:javascript src="dist/js/app-style-switcher.horizontal.js"/>
<!-- slimscrollbar scrollbar JavaScript -->
<asset:javascript src="perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"/>
<asset:javascript src="extra-libs/sparkline/sparkline.js"/>
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
<asset:javascript src="extra-libs/c3/d3.min.js"/>
<asset:javascript src="extra-libs/c3/c3.min.js"/>
<!--chartjs -->
<asset:javascript src="raphael/raphael.min.js"/>
<asset:javascript src="morris.js/morris.min.js"/>

<asset:javascript src="dist/js/pages/dashboards/dashboard1.js"/>

<g:pageProperty name="page.js"/>

</body>

</html>