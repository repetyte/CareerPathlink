<?php
include 'db.php';

$id = $_POST['grad_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$cp_no = $_POST['cp_no'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$emp_stat = $_POST['emp_stat'];

$sql = "UPDATE graduates_lists SET full_name='$full_name', age=$age, address='$address', cp_no='$cp_no', course='$course', date_grad='$date_grad', emp_stat='$emp_stat' WHERE grad_id=$id";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
