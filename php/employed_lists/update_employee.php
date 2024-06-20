<?php
include 'db.php';

$id = $_POST['emp_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$cp_no = $_POST['cp_no'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$job_name = $_POST['job_name'];
$job_industry = $_POST['job_industry'];
$salary = $_POST['salary'];
$date_hired = $_POST['date_hired'];

$sql = "UPDATE employed_lists SET full_name='$full_name', age=$age, address='$address', cp_no='$cp_no', course='$course', date_grad='$date_grad', job_name='$job_name', job_industry='$job_industry', salary=$salary, date_hired='$date_hired' WHERE emp_id=$id";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
