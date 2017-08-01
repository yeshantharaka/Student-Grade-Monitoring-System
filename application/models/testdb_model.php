<?php

class testdb_model extends CI_Model
{

    public function getMsg($data)
    {
//        $results = $this->db->query("select * from users");
//
//        return $results->num_rows();

//        $grade = $data['grade'];
//        $class = $data['class'];

        // $results = $this->db->query("select * from class where year = 2016 and grade = $grade and name = '$class'");
        //echo "select id from class where year = 2016 and grade = $grade and name = '$class'";

        $results = $this->db->query("select * from student")->result_array();
        return $results;
    }

    public function getMarks($index)
    {
        //$result = $this->db->query("select * from");

        return array("name" => "dinuka");

    }

}