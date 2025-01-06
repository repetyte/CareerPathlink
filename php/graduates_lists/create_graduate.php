<?php
include 'db.php';

$graduate_id = $_POST['graduate_id'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$contact_no = $_POST['contact_no'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$emp_stat = $_POST['emp_stat'];

$sql = "INSERT INTO graduates_lists (graduate_id, full_name, age, address, contact_no, course, date_grad, emp_stat) VALUES ('$graduate_id', '$full_name', $age, '$address', '$contact_no', '$course', '$date_grad', '$emp_stat')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
