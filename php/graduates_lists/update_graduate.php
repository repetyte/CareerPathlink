<?php
include 'db.php';

$id = $_POST['grad_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$cp_no = $_POST['cp_no'];
$course = $_POST['course'];
$emp_stat = $_POST['emp_stat'];
$date_grad = $_POST['date_grad'];

$sql = "UPDATE graduates_lists SET full_name='$full_name', age=$age, address='$address', cp_no='$cp_no', course='$course', emp_stat='$emp_stat', date_grad='$date_grad' WHERE grad_id=$id";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
