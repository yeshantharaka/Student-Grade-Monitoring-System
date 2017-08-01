<div class="sidebar" data-color="blue" data-image="<?php echo base_url() ?>assets/img/sidebar-1.jpg">
    <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->

    <div class="logo">
        <a href="" class="simple-text">
            <h4>SGM System</h4>
            <?php echo '<h6>' . $this->session->userdata('version') . ' Edition </h6>' ?>
        </a>

    </div>

    <div class="sidebar-wrapper">
        <ul class="nav">
            <!--            <li class="--><?php //if ($active === 'overall') echo 'active' ?><!--">-->
            <!--                <a href="--><?php //echo site_url('overall'); ?><!--">-->
            <!--                    <i class="material-icons">library_books</i>-->
            <!--                    <p>Overall Class</p>-->
            <!--                </a>-->
            <!--            </li>-->
            <li class="<?php if ($active === 'dashboard') echo 'active' ?>">
                <a href="<?php echo site_url('dashboard'); ?>">
                    <i class="material-icons">dashboard</i>
                    <p>Dashboard</p>
                </a>
            </li>
            <li class="<?php if ($active === 'user') echo 'active' ?>">
                <a href="<?php echo site_url('user'); ?>">
                    <i class="material-icons">person</i>
                    <p>User Profile</p>
                </a>
            </li>
            <!--            <li class="--><?php //if ($active === 'table_list') echo 'active' ?><!--">-->
            <!--                <a href="--><?php //echo site_url('tablelist'); ?><!--">-->
            <!--                    <i class="material-icons">content_paste</i>-->
            <!--                    <p>Table List</p>-->
            <!--                </a>-->
            <!--            </li>-->

            <li class="<?php if ($active === 'upload') echo 'active' ?>">
                <a href="<?php echo site_url('upload'); ?>">
                    <i class="material-icons">file_upload</i>
                    <p>Upload CSV</p>
                </a>
            </li>
            <li class="">
                <a href="<?php echo site_url('login/logout'); ?>">
                    <i class="material-icons">trending_down</i>
                    <p>Log out</p>
                </a>
            </li>


        </ul>
    </div>
</div>
