<?php
include 'db.php';

$id = $_POST['id'];
$previous_job = $_POST['previous_job'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$reason_unemp = $_POST['reason_unemp'];
$next_target_job = $_POST['next_target_job'];

$sql = "UPDATE unemployed_lists SET previous_job='$previous_job', full_name='$full_name', age=$age, address='$address', course='$course', date_grad='$date_grad', reason_unemp='$reason_unemp', next_target_job='$next_target_job' WHERE id=$id";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
