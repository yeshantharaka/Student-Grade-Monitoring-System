<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-12
 * Time: 8:34 AM
 */

// Handle the database transaction for class tables...
class  Class_model extends CI_Model
{

    
    // Get the all grades from class table in db
    public function getAllGrades()
    {
        $restult = $this->db
            ->query("SELECT DISTINCT grade FROM class c")
            ->result_array();

        return $restult;
    }

    // Get class names like A, B, C from class table
    public function getAllClassNames()
    {
        $restult = $this->db
            ->query("SELECT DISTINCT name FROM class c")
            ->result_array();

        return $restult;
    }

    
    // Get the classId for grade and class name like 6-A
    public function getClassId($grade, $name)
    {
        $restult = $this->db
            ->query("SELECT id FROM class c WHERE grade = $grade AND name = '$name'")
            ->row_array();

        return $restult['id'];
    }

    // Get the years of classes that student leart
    public function getYearListForStudent($index)
    {
        $restult = $this->db
            ->query("SELECT DISTINCT year FROM class c, student_class sc where c.id = sc.Class_id and sc.Student_index = $index")
            ->result_array();

        return $restult;
    }

}