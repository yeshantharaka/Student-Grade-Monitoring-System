<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Students/Teacher</title>

    <link rel="stylesheet" href="<?php echo base_url() ?>assets/css/reset.min.css">

    <!--    <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>-->
    <!--    <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>-->

    <!--     Fonts and icons     -->
    <link href="<?php echo base_url() ?>assets/css/font-awesome.min.css" rel="stylesheet">
    <link href='<?php echo base_url() ?>assets/css/google_fonts.css' rel='stylesheet' type='text/css'>

    <script src="<?php echo base_url() ?>assets/js/jquery-3.1.0.min.js"></script>
    <script src="<?php echo base_url() ?>assets/js/jquery-ui.min.js"></script>


    <link rel="stylesheet" href="<?php echo base_url() ?>assets/css/loginstyle.css">


</head>

<body>

<!-- Form Mixin-->
<!-- Input Mixin-->
<!-- Button Mixin-->
<!-- Pen Title-->
<div class="pen-title">
    <h1>Login - Students/Teacher</h1>

    <?php
        if($this->session->flashdata('error')){
            $msg = $this->session->flashdata('msg');
            echo "<h5 style=\"color: red\">$msg</h5>";
        }
    ?>

</div>
<!-- Form Module-->
<div class="module form-module">
    <div class="toggle"><i class="fa fa-times fa-pencil"></i>
        <div class="tooltip">Click To Teacher Login</div>
    </div>



    <div class="form">
        <h2>Student Login</h2>
        <form method="post" action="<?= site_url('login/student')?>">
            <input name="username" type="text" placeholder="Username"/>
            <input name="password" type="password" placeholder="Password"/>
            <button>Login</button>
        </form>
    </div>
    <div class="form">
        <h2>Teacher Login</h2>
        <form  method="post" action="<?= site_url('login/teacher')?>">
            <input  name="username" type="text" placeholder="Username"/>
            <input  name="password" type="password" placeholder="Password"/>
            <button>Login</button>
        </form>
        <!--
            <h2>Create an account</h2>
            <form>
              <input type="text" placeholder="Username"/>
              <input type="password" placeholder="Password"/>
              <input type="email" placeholder="Email Address"/>
              <input type="tel" placeholder="Phone Number"/>
              <button>Register</button>
            </form>
        -->
    </div>
    <div class="cta"><a href="#">Forgot your password?</a></div>
</div>
<!--<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>-->
<!--<script src='http://codepen.io/andytran/pen/vLmRVp.js'></script>-->

<script type="text/javascript">
    $('.toggle').click(function () {
        // Switches the Icon
        $(this).children('i').toggleClass('fa-pencil');
        // Switches the forms
        $('.form').animate({
            height: "toggle",
            'padding-top': 'toggle',
            'padding-bottom': 'toggle',
            opacity: "toggle"
        }, "slow");
    });
</script>

</body>
</html>
