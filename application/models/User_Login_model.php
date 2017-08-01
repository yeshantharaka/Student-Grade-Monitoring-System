<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-13
 * Time: 11:05 PM
 */
class User_Login_model extends CI_Model
{

    //check where there is entry for specific username and password for teacher
    public function authTeacher($username, $password)
    {
        $restult = $this->db
            ->query("SELECT * from teacher_user u, teacher t WHERE t.id = u.Teacher_id AND username = '$username' and password = '$password'")

            ->result_array();

        return $restult;
    }

    //check where there is entry for specific username and password for student
    public function authStudent($username, $password)
    {
        $restult = $this->db
            ->query("SELECT * from student_user u, student s WHERE u.Student_index = s.index AND username = '$username' and password = '$password'")
            ->result_array();

        return $restult;
    }

}