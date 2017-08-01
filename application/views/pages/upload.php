<div class="main-panel">
    <nav class="navbar navbar-transparent navbar-absolute">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">CSV file upload</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#pablo" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="material-icons">dashboard</i>
                            <p class="hidden-lg hidden-md">Dashboard</p>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="material-icons">notifications</i>
                            <span class="notification">5</span>
                            <p class="hidden-lg hidden-md">Notifications</p>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Mike John responded to your email</a></li>
                            <li><a href="#">You have 5 new tasks</a></li>
                            <li><a href="#">You're now friend with Andrew</a></li>
                            <li><a href="#">Another Notification</a></li>
                            <li><a href="#">Another One</a></li>
                        </ul>
                    </li>
                    <li>
                        <i class="material-icons">account_circle</i>
                        <?php
                        if ($this->session->userdata('logged')) {
                            $user = $this->session->userdata('user');
                            if ($this->session->userdata('version') == 'Student') {
                                $username = $user[0]['fname'] . ' ' . $user[0]['lname'];
                            } else {
                                $username = $user[0]['name'];
                            }
                            echo "<p class=''>$username</p>";
                        }
                        ?>
                    </li>
<!--                    <li>-->
<!--                        <a href="#pablo" id="log_out_btn" class="btn btn-link">-->
<!--                            Log out-->
<!--                            <p class="hidden-lg hidden-md">Profile</p>-->
<!--                        </a>-->
<!--                    </li>-->
                </ul>

                <form class="navbar-form navbar-right" role="search">
                    <div class="form-group  is-empty">
                        <input type="text" class="form-control" id="search" placeholder="Search">
                        <span class="material-input"></span>
                    </div>
                    <button type="submit" class="btn btn-white btn-round btn-just-icon">
                        <i class="material-icons">search</i>
                        <div class="ripple-container"></div>
                    </button>
                </form>
            </div>
        </div>
    </nav>
    <div class="content">


        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8" align="center">
                <div class="card card-nav-tabs">
                    <div class="card-header" data-background-color="purple">
                        <div class="nav-tabs-navigation">
                            <div class="nav-tabs-wrapper">
                                <span class="nav-tabs-title">CSV</span>
                                <ul class="nav nav-tabs" data-tabs="tabs">

                                    <li class="active">
                                        <a href="#messages" data-toggle="tab">
                                            <i class="material-icons">list</i>
                                            Marks for each subject
                                            <div class="ripple-container"></div>
                                        </a>
                                    </li>
                                    <!--                                    <li class="">-->
                                    <!--                                        <a href="#settings" data-toggle="tab">-->
                                    <!--                                            <i class="material-icons">class</i>-->
                                    <!--                                            Class marks-->
                                    <!--                                            <div class="ripple-container"></div>-->
                                    <!--                                        </a>-->
                                    <!--                                    </li>-->
                                    <li class="">
                                        <a href="#profile" data-toggle="tab">

                                            <i class="material-icons">supervisor_account</i>
                                            Student List
                                            <div class="ripple-container"></div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="card-content">
                        <div class="tab-content">

                            <div class="tab-pane active" id="messages">
                                <table class="table ">
                                    <tbody>
                                    <tr>

                                        <td class="form-rose">

                                            <form class="form-inline" action="upload/subject_marks" method="POST"
                                                  enctype="multipart/form-data">
                                                <label class="form-group">Select Subject marks CSV file to
                                                    upload:</label>

                                                <br>
                                                <div class="form-group">
                                                    <select
                                                        class="dropdown-header dropdown" name="grade">
                                                        <option value=null disabled selected hidden>Select Grade
                                                        </option>
                                                        <?php
                                                        foreach ($grades as $g) {

                                                            echo "<option value='" . $g['grade'] . "'>" . $g['grade'] . "</option>";
                                                        }
                                                        ?>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <select
                                                        class="dropdown-header dropdown" name="class">
                                                        <option value=null disabled selected hidden>Select Class
                                                        </option>

                                                        <?php
                                                        foreach ($classes as $g) {

                                                            echo "<option value='" . $g['name'] . "'>" . $g['name'] . "</option>";
                                                        }
                                                        ?>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <select
                                                        class="dropdown-header dropdown" name="subject">
                                                        <option value=null disabled selected hidden>Select Subject
                                                        </option>
                                                        <?php
                                                        foreach ($subjects as $subject) {
                                                            echo "<option value='" . $subject['code'] . "'>" . $subject['name'] . "</option>";
                                                        }

                                                        ?>

                                                    </select>
                                                </div>


                                                <input class="form-group btn btn-block" type="file" name="file"
                                                >
                                                <input class="form-group btn btn-twitter" type="submit"
                                                       value="Upload CSV" name="submit">
                                            </form>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td>

                                        </td>
                                        <td></td>
                                        <td class="td-actions text-right">

                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--                            <div class="tab-pane" id="settings">-->
                            <!--                                <table class="table ">-->
                            <!--                                    <tbody>-->
                            <!--                                    <tr>-->
                            <!---->
                            <!--                                        <td class="form-rose">-->
                            <!---->
                            <!--                                            <form class="form-inline" action="upload/class_marks" method="post"-->
                            <!--                                                  enctype="multipart/form-data">-->
                            <!--                                                <label class="form-group">Select Class marks CSV file to upload:</label>-->
                            <!---->
                            <!--                                                <br>-->
                            <!--                                                <div class="form-group">-->
                            <!--                                                    <select-->
                            <!--                                                        class="dropdown-header dropdown" name="grade">-->
                            <!--                                                        <option value=null disabled selected hidden>Select Grade-->
                            <!--                                                        </option>-->
                            <!--                                                        --><?php
                            //                                                        foreach ($grades as $g) {
                            //
                            //                                                            echo "<option value='" . $g['grade'] . "'>" . $g['grade'] . "</option>";
                            //                                                        }
                            //                                                        ?>
                            <!--                                                    </select>-->
                            <!--                                                </div>-->
                            <!--                                                <div class="form-group">-->
                            <!--                                                    <select-->
                            <!--                                                        class="dropdown-header dropdown" name="class">-->
                            <!--                                                        <option value=null disabled selected hidden>Select Class-->
                            <!--                                                        </option>-->
                            <!--                                                        --><?php
                            //                                                        foreach ($classes as $g) {
                            //
                            //                                                            echo "<option value='" . $g['name'] . "'>" . $g['name'] . "</option>";
                            //                                                        }
                            //                                                        ?>
                            <!--                                                    </select>-->
                            <!--                                                </div>-->
                            <!---->
                            <!--                                                <input class="form-group btn btn-block" type="file" name="file"-->
                            <!--                                                       id="fileToUpload">-->
                            <!--                                                <input class="form-group btn btn-instagram" type="submit"-->
                            <!--                                                       value="Upload CSV" name="submit">-->
                            <!--                                            </form>-->
                            <!---->
                            <!--                                        </td>-->
                            <!---->
                            <!--                                    </tr>-->
                            <!--                                    <tr>-->
                            <!--                                        <td>-->
                            <!---->
                            <!--                                        </td>-->
                            <!--                                        <td></td>-->
                            <!--                                        <td class="td-actions text-right">-->
                            <!---->
                            <!--                                        </td>-->
                            <!--                                    </tr>-->
                            <!--                                    </tbody>-->
                            <!--                                </table>-->
                            <!--                            </div>-->

                            <div class="tab-pane" id="profile">
                                <table class="table ">
                                    <tbody>
                                    <tr>

                                        <td class="form-rose">

                                            <form class="form-inline" action="upload/student_list" method="post"
                                                  enctype="multipart/form-data">
                                                <label class="form-group">Select Student list CSV file to
                                                    upload:</label> <br>
                                                <div class="form-group">
                                                    <select
                                                        class="dropdown-header dropdown" name="grade">
                                                        <option value=null disabled selected hidden>Select Grade
                                                        </option>

                                                        <?php
                                                        foreach ($grades as $g) {

                                                            echo "<option value='" . $g['grade'] . "'>" . $g['grade'] . "</option>";
                                                        }
                                                        ?>

                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <select
                                                        class="dropdown-header dropdown" name="class">
                                                        <option value=null disabled selected hidden>Select Class
                                                        </option>
                                                        <?php
                                                        foreach ($classes as $g) {

                                                            echo "<option value='" . $g['name'] . "'>" . $g['name'] . "</option>";
                                                        }
                                                        ?>
                                                    </select>
                                                </div>


                                                <input class="form-group btn btn-block" type="file" name="file"
                                                       id="fileToUpload">
                                                <input class="form-group btn btn-success" type="submit"
                                                       value="Upload CSV" name="submit">
                                            </form>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td>

                                        </td>
                                        <td></td>
                                        <td class="td-actions text-right">

                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-2"></div>
        </div>

        <!--        --><?php
        //        print_r($grades);
        //        ?>

        <!--        <div><button id="btnu">click</button><input type="text" id="txt"/> </div>-->
    </div>

</div>

<script type="text/javascript">

    $(document).ready(function () {
        grades = JSON.parse('<?= json_encode($grades)?>');
        classes = JSON.parse('<?= json_encode($classes)?>');

        console.log(grades + ' ' + classes);
    });


</script>


