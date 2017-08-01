<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-12
 * Time: 10:08 PM
 */
class Marks_model extends CI_Model
{
    
    //Insert marks for database
    public function insertMarks($data)
    {
        return $this->db->insert('marks', $data);
    }
}