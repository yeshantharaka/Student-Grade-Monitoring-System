<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-12
 * Time: 6:18 PM
 */
class Login extends CI_Controller
{


    // Initial login page controlling method
    public function index()
    {
        $this->load->view('pages/login');
    }

    // When there is student login the student's credential will check with this function
    public function student()
    {
        echo 'student';
        $username =  $this->input->post('username');
        $password = $this->input->post('password');

        $res = $this->User_Login_model->authStudent($username, $password);

        if (count($res) == 1){
            $user_data = array(
                'logged' => true,
                'user' => $res,
                'version' => 'Student'
            );

            $this->session->set_userdata($user_data);
            redirect(site_url('dashboard'));
        } else {
            $flashdata = array(
                'error' => true,
                'msg' => 'Invalid username/password... Try again!'
            );
            $this->session->set_flashdata($flashdata);
            redirect(site_url('login'));
        }



    }

    // When logout request come, this function will executed
    public function logout()
    {
        $this->session->unset_userdata('logged');
        redirect('login');
    }

    // When there is teacher login the teacher's credential will check with this function
    public function teacher()
    {
        echo 'teacher';
        $username =  $this->input->post('username');
        $password = $this->input->post('password');

        $res = $this->User_Login_model->authTeacher($username, $password);

        if (count($res) == 1) {
            $user_data = array(
                'logged' => true,
                'user' => $res,
                'version' => 'Teacher'
            );

            $this->session->set_userdata($user_data);
            redirect(site_url('dashboard'));

        }else {
            $flashdata = array(
                'error' => true,
                'msg' => 'Invalid username/password... Try again!'
            );
            $this->session->set_flashdata($flashdata);
            redirect(site_url('login'));
        }
    }
}