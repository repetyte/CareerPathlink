<?php
include 'db.php';

$id = $_POST['graduate_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$contact_no = $_POST['contact_no'];
$course = $_POST['course'];
$emp_stat = $_POST['emp_stat'];
$date_grad = $_POST['date_grad'];

$sql = "UPDATE graduates_lists SET full_name='$full_name', age=$age, address='$address', contact_no='$contact_no', course='$course', emp_stat='$emp_stat', date_grad='$date_grad' WHERE graduate_id=$id";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
