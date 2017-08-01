<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-12
 * Time: 8:35 AM
 */
class Subject_model extends CI_Model
{
    public function getAllSubjectsOfClass($classId)
    {
        $restult = $this->db
            ->query("SELECT DISTINCT s.* FROM class c, student_class sc, marks m, subject s WHERE c.id = sc.Class_id AND sc.id = m.Student_Class_id AND m.Subject_code = s.code AND c.id = $classId")
            ->result_array();

        return $restult;
    }


    public function getAllSubjects()
    {
        $restult = $this->db
            ->query("SELECT DISTINCT name, code FROM Subject")
            ->result_array();

        return $restult;
    }

}