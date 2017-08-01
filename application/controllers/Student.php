<?php

/**
 * Created by PhpStorm.
 * User: HP
 * Date: 2016-11-22
 * Time: 2:12 PM
 */
class Student extends CI_Controller
{


    
    public function search()
    {
        $search = $this->input->post('search');
        // echo $search;
        $query = $this->Student_model->searchStudent($search);
//        echo $query;
        //echo "<br>";
        echo json_encode($query);
    }

    // Search the all student by startswith index number  in dashboard
    public function allStudents()
    {
        $index = $this->input->post('index');
        $sc_id = $this->Student_model->getStudent_s_Class_for_year($index);
        $result = $this->Student_model->getAllStudentOfClass($sc_id);

        echo json_encode($result);

    }

    // To get the rank for last year result for index of the student
    public function getRankForLatestYear()
    {
        $index = $this->input->post('index');
        $result = $this->Student_model->getSumOfMarksOfClass($index);
        //print_r($result);

        $x = 1;
        foreach ($result as $obj) {

            if ($obj['Student_index'] == $index) {
                // echo $obj['Student_index'] . " --------<br>";
                break;
            }
            $x++;

        }

        echo $x;


    }

    
    // Get the ranks for all students in specific student's class
    public function getRanks()
    {
        $index = $this->input->post('index');
        $years = $this->Class_model->getYearListForStudent($index);

        $ranks = array();

        foreach ($years as $y) {

            // print_r($y);
            $yr = $y['year'];

            $result = $this->Student_model->getSumOfMarksOfClassForYear($index, $yr);
            //  print_r($result);

            $x = 1;
            foreach ($result as $obj) {

                if ($obj['Student_index'] == $index) {
                    // echo $obj['Student_index'] . " --------<br>";
                    break;
                }
                $x++;

            }

            $ranks["$yr"] = $x;


        }
        echo json_encode($ranks);


    }


    // Average marks for two students to compare marks
    public function avgMarksForStudent()
    {
        $index1 = $this->input->post('index1');
        $index2 = $this->input->post('index2');
        $code = $this->input->post('code');
        $data1 = $this->Student_model->getAvgMarksForIndex($index1, $code);
        $data2 = $this->Student_model->getAvgMarksForIndex($index2, $code);

        echo json_encode(array(
            'data1' => $data1,
            'data2' => $data2
        ));

    }

    // Get the names of two students, search by index no
    public function namesOfStudents()
    {
        $index1 = $this->input->post('index1');
        $index2 = $this->input->post('index2');

        $student1 = $this->Student_model->searchStudent($index1);
        $student2 = $this->Student_model->searchStudent($index2);

        $student1 = reset($student1);
        $student2 = reset($student2);


        echo json_encode(array(
            'name1' => $student1['fname'] . ' ' . $student1['lname'],
            'name2' => $student2['fname'] . ' ' . $student2['lname']
        ));


    }

    // Get the marks for specific subject for two students to compare marks
    public function cmp_student_subject()
    {

        $student_index = $this->input->post('student');
        $index = $this->input->post('index');
        $code = $this->input->post('code');
        $result1 = $this->Student_model->get_marks_for_subject($student_index, $code);
        $result2 = $this->Student_model->get_marks_for_subject($index, $code);


        echo json_encode(array($result1, $result2));
    }


    // This is test function to check db is working
    public function marks()
    {
        $index = $this->input->post('index');

        $result = $this->testdb_model->getMarks($index);

        echo json_encode($result);
    }

    // Get the current grade of student search by index number
    public function getGrade()
    {
        $index = $this->input->post('index');
        $result = $this->Student_model->getGradeForIndex($index);
        echo json_encode($result);
    }



    // Get the marks of class first/top
    public function class1stMarks()
    {

        $index = $this->input->post('index');

        $classId = $this->Student_model->getStudent_s_Class_for_year($index);

        //  echo 'class id ',$classId;
        $class1stIndex = $this->Student_model->getClassFirstId($classId);

        // echo '<br> class 1st id ',$class1stIndex;


        $marksResult = $this->Student_model->getMarksForStudent($class1stIndex);
        // echo '<br> Mark result ',json_encode($marksResult);
        $marks = [];

        foreach ($marksResult as $key => $value) {

            if ($value['term'] == 3) {
                array_push($marks, $value['value']);
            }


        }

        echo json_encode($marks);

    }

    // Get the all student's average marks for every subject in specific student's class
    public function allClassAvgMarks()
    {
        $index = $this->input->post('index');

        $result = $this->Student_model->getAllClassAvgMarks($index);


        echo json_encode($result);
    }

    
    //Get the last term's marks for specific student
    public function getLastTermMarks()
    {
        $index = $this->input->post('index');
        $classId = $this->Student_model->getStudent_ClassId($index);
        $marksResult = $this->Student_model->getMarksForStudent($classId);

        $terms = [];
        $subjects = [];
        $marks = [];

        foreach ($marksResult as $key => $value) {


            if (!in_array($value['term'], $terms, false)) {
                array_push($terms, $value['term']);
            }
            if (!in_array($value['name'], $subjects, false)) {
                array_push($subjects, $value['name']);
            }

            array_push($marks, $value['value']);


        }

        $result = [$terms, $subjects, $marks];

        echo json_encode($result);


    }


    // Get class average for each subject in specific student's class
    public function getClassAvgMarks()
    {
        $index = $this->input->post('index');

        $classId = $this->Student_model->getStudent_s_Class_for_year($index);
//        echo $classId;
        $result = $this->Student_model->getClassAvg($classId);
//        echo $result;
        echo json_encode($result);


    }

    //This is also test function
    public function test()
    {
        $result = $this->Student_model->getClassFirstId(1);
//        echo json_encode($result);
        echo $result;
    }

}