<?php

class Upload extends CI_Controller
{
     /**
     * Index Page for this controller.
     *
     */
    public function index()
    {

         // Check whether some user is logged in or not
        if (!$this->session->userdata('logged')) {
            echo "You are not logged....";

            redirect('login');
        } else {
            $this->load->view('template/header');

            $grades = $this->Class_model->getAllGrades();
            $classes = $this->Class_model->getAllClassNames();
            $subjects = $this->Subject_model->getAllSubjects();


            $data = array(
                'active' => 'upload',
                'grades' => $grades,
                'classes' => $classes,
                'subjects' => $subjects
            );

            $this->load->view('template/side_bar', $data);

            $this->load->view('pages/upload');

            $this->load->view('template/footer');
        }
    }


    
    // Upload CSV file to with marks for specific subject
    public function subject_marks()
    {

        $grade = $this->input->post('grade');

        $name = $this->input->post('class');

        $subject = $this->input->post('subject');

        $classId = $this->Class_model->getClassId($grade, $name);

        $file = $_FILES['file']['tmp_name'];


        $handle = fopen($file, "r");


        while (($fileop = fgetcsv($handle, 1000, ",")) !== false) {
            if ($fileop[0] != 'index') {


                $index = $fileop[0];

                $studentClassId = $this->Student_Class_model->getStudentClassID($classId, $index);


                $value = intval($fileop[1]);
                $term = $fileop[2];

                $gradePoint = 'A';

                if ($value < 35) {
                    $gradePoint = 'F';
                } else if ($value < 50) {
                    $gradePoint = 'S';
                } else if ($value < 65) {
                    $gradePoint = 'C';
                } else if ($value < 75) {
                    $gradePoint = 'B';
                }


                $data = array(
                    'Student_Class_id' => $studentClassId,
                    'Subject_code' => $subject,
                    'value' => $value,
                    'term' => $term,
                    'grade' => $gradePoint

                );

                $res = $this->Marks_model->insertMarks($data);


                if ($res == 1) {
                    echo 'File uploaded successfully';
                }

            };
        }


    }

    // Upload CSV file to with Students for specific class
    public function student_list()
    {
        $grade = $this->input->post('grade');
        $name = $this->input->post('class');


        $classId = $this->Class_model->getClassId($grade, $name);

        $file = $_FILES['file']['tmp_name'];


        $handle = fopen($file, "r");


        while (($fileop = fgetcsv($handle, 1000, ",")) !== false) {

            if ($fileop[0] != 'index') {

                $index = $fileop[0];
                $fname = $fileop[1];
                $lname = $fileop[2];
                $address = $fileop[3];
                $tele = $fileop[4];
                $data = array(
                    'index' => $index,
                    'fname' => $fname,
                    'lname' => $lname,
                    'address' => $address,
                    'tel' => $tele,
                );

                $res = $this->Student_model->insertStudent($data);

                if ($res == 1) {
                    $data = array(
                        'Student_index' => $index,
                        'Class_id' => $classId
                    );
                    $res = $this->Student_Class_model->registerStudentsToClass($data);


                }
                if ($res == 1) {
                    echo 'File uploaded successfully';
                }

            };

        }

    }

    // Upload CSV file to with class marks for all subject
    // UNDER CONSTRUCTION
    public function class_marks()
    {
        $grade = $this->input->post('grade');
        $name = $this->input->post('class');


        $classId = $this->Class_model->getClassId($grade, $name);

        $file = $_FILES['file']['tmp_name'];


        $handle = fopen($file, "r");


        while (($fileop = fgetcsv($handle, 1000, ",")) !== false) {

            if ($fileop[0] != 'index') {

            }
        }
    }


}

