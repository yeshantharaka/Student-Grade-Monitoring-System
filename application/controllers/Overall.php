<?php

class Overall extends CI_Controller
{
    public function index()
    {


        $this->load->view('template/header');


        $data = array(
            'active' => 'overall'
        );

        $this->load->view('template/side_bar', $data);

        $this->load->view('pages/overall');

        $this->load->view('template/footer');
    }
}

