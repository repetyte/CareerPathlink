<?php
include 'db.php';

$emp_id = $_POST['emp_id'];
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

$sql = "INSERT INTO employed_lists (emp_id, full_name, age, address, cp_no, course, date_grad, job_name, job_industry, salary, date_hired) VALUES ($emp_id, '$full_name', $age, '$address', '$cp_no', '$course', '$date_grad', '$job_name', '$job_industry', $salary, '$date_hired')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
