<?php
include 'db.php';

$grad_id = $_POST['grad_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$cp_no = $_POST['cp_no'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$emp_stat = $_POST['emp_stat'];

$sql = "INSERT INTO graduates_lists (grad_id, full_name, age, address, cp_no, course, date_grad, emp_stat) VALUES ('$grad_id', '$full_name', $age, '$address', '$cp_no', '$course', '$date_grad', '$emp_stat')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
