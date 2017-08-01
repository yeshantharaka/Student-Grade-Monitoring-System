<?php

class TableList extends CI_Controller
{
    public function index()
    {
        $this->load->view('template/header');


        $data = array(
            'active' => 'table_list'
        );

        $this->load->view('template/side_bar', $data);

        $this->load->view('pages/table_list');

        $this->load->view('template/footer');
    }
}