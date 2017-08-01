<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-12-10
 * Time: 5:45 PM
 */
class Student_model extends CI_Model
{
    public function searchStudent($index)
    {
//        $results = $this->db->query("select * from student WHERE fname like '$name%' or lname like '$name%'")->result_array();
        $results = $this->db->query("select * from student s WHERE s.index like '$index%'")->result_array();
        return $results;
    }

    public function getAvgMarksForIndex($index, $code)
    {
        $restult = $this->db
            ->query("SELECT c.grade, c.name as class_name, AVG(m.value) as avg
                FROM class c, marks m, student_class sc, subject s
                WHERE c.id = sc.Class_id AND m.Student_Class_id = sc.id AND sc.Student_index = $index  AND s.code = m.Subject_code
                AND s.code = '$code'
                GROUP BY c.id")
            ->result_array();

        return $restult;
    }

    public function getGradeForIndex($index)
    {
        $this->db->select('c.grade, c.name');
        $this->db->from('Class c');

        $this->db->where(
            'Student_index', $index
        );


        $this->db->order_by('year', 'desc');
        $this->db->limit(1);

        $this->db->join('Student_Class sc', 'sc.Class_id = c.id', 'left');


        return $this->db->get()->result_array();
//        return 'test';

    }

    public function getLatestClassYear($index)
    {


        $result = $this->db->get()->row_array();

        return $result['year'];
    }

    public function insertStudent($data)
    {
        return $this->db->insert('student', $data);
    }


    public function get_marks_for_subject($index, $code)
    {
        $restult = $this->db
            ->query("SELECT m.value, m.term, c.grade, c.name AS class_name
         FROM marks m, subject s, student_class sc, class c 
         WHERE sc.Class_id = c.id AND m.Student_Class_id = sc.id AND m.Subject_code = s.code AND sc.Student_index = $index AND s.code = $code")
            ->result_array();

        return $restult;
    }

    public function getAllStudentOfClass($classId)
    {
        $restult = $this->db
            ->query("SELECT s.* FROM student s, student_class sc, class c WHERE s.index = sc.Student_index
                        AND sc.Class_id = c.id AND c.id=$classId")
            ->result_array();

        return $restult;
    }

    public function getStudent_s_Class_for_year($index)
    {

        $this->db->select('year');
        $this->db->from('Class c');
        $this->db->where([

            'Student_index' => $index
        ]);
        $this->db->join('Student_Class sc', 'sc.Class_id = c.id', 'left')
            ->order_by('year', 'desc')
            ->limit(1);
        $sub_query = $this->db->get_compiled_select();


        $this->db->select('c.id');
        $this->db->from('Class c');
        $this->db->where("year = ($sub_query)", null, false);
        $this->db->where([

            'Student_index' => $index
        ]);
        $this->db->join('Student_Class sc', 'sc.Class_id = c.id', 'left');

//        return $this->db->get_compiled_select();

        $result = $this->db->get()->row_array();

        return $result['id'];

    }

    public function getStudent_ClassId($index)
    {
        $this->db->select('sc.id');
        $this->db->from('Class c');
        $this->db->where([

            'Student_index' => $index
        ]);
        $this->db->join('Student_Class sc', 'sc.Class_id = c.id', 'left')
            ->order_by('year', 'desc')
            ->limit(1);

        $result = $this->db->get()->row_array();

        return $result['id'];

    }

    public function getClassFirstId($classId)
    {
        $restult = $this->db
            ->query("SELECT sc.id FROM marks m, student_class sc WHERE m.Student_Class_id = sc.id 
    AND m.Student_Class_id in (SELECT id from student_class where Class_id = $classId) AND m.term = 3 GROUP BY m.Student_Class_id 
    ORDER BY SUM(m.value) DESC LIMIT 1")
            ->row_array();
        return $restult['id'];
    }

    public function getAllClassAvgMarks($index)
    {

        $restult = $this->db
            ->query("SELECT c.grade, c.name as class_name, AVG(m.value) as avg , s.name as subject_name
                FROM class c, marks m, student_class sc, subject s
                WHERE c.id = sc.Class_id AND m.Student_Class_id = sc.id AND sc.Student_index = $index  AND s.code = m.Subject_code
                GROUP BY c.id, m.Subject_code")
            ->result_array();

        return $restult;

    }


    public function getClassAvg($class_id)
    {
        $restult = $this->db
            ->query("SELECT AVG(value) as avg, name FROM marks m, subject s WHERE m.subject_code = s.code 
          AND Student_Class_id IN (SELECT id from student_class where Class_id = $class_id) and term = 3 GROUP by (subject_code)")
            ->result_array();
        return $restult;
    }

    public function getMarksForStudent($class_id)
    {
        $this->db->select('name, value, term')
            ->from('Marks m')
            ->join('Subject s', 's.code = m.Subject_code', 'left')
            ->where('Student_Class_id', $class_id)
            ->order_by('term', 'asc');

        $result = $this->db->get()->result_array();
        return $result;
    }


    public function getSumOfMarksOfClass($index)
    {

        return $this->db->query("SELECT SUM(m.value) as total, sc.Student_index FROM marks m, student_class sc
             WHERE m.Student_Class_id = sc.id AND m.term = 3 
             AND sc.Class_id = 
             (SELECT c.id from class c, student_class s WHERE c.id = s.Class_id AND s.Student_index = $index ORDER BY c.year DESC LIMIT 1)
              GROUP BY sc.Student_index ORDER BY 1 DESC")
            ->result_array();


    }

    public function getSumOfMarksOfClassForYear($index, $year)
    {

        return $this->db->query("SELECT SUM(m.value) as total, sc.Student_index FROM marks m, student_class sc
             WHERE m.Student_Class_id = sc.id AND m.term = 3 
             AND sc.Class_id = 
             (SELECT c.id from class c, student_class s WHERE c.id = s.Class_id AND s.Student_index = $index AND c.year = $year)
              GROUP BY sc.Student_index ORDER BY 1 DESC")
            ->result_array();


    }

}