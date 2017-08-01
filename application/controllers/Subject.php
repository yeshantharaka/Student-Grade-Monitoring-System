<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-12
 * Time: 8:37 AM
 */
class Subject extends CI_Controller
{
    
    //Get the subject for all subjects
    public function subjectForClass()
    {
        $index = $this->input->post('index');
        $sc_id = $this->Student_model->getStudent_s_Class_for_year($index);
        $result = $this->Subject_model->getAllSubjectsOfClass($sc_id);

        echo json_encode($result);
    }
}
