<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_Controller
{

    /**
     * Index Page for this controller.
     *
     */
    public function index()
    {


        // Check whether some user is logged in or not
        if (!$this->session->userdata('logged')) {
            echo "You are not logged....";
            
            redirect('login'); // If not logged the request redirected to the login page
        }else{

            $this->load->view('template/header');


            $data = array(
                'active' => 'dashboard'
            );

            $this->load->view('template/side_bar', $data);

            $this->load->view('pages/dashboard');

            $this->load->view('template/footer');
        }


    }
}
