<?php
include 'db.php';

$previous_job = $_POST['previous_job'];
$full_name = $_POST['full_name'];
$age = $_POST['age'];
$address = $_POST['address'];
$course = $_POST['course'];
$date_grad = $_POST['date_grad'];
$reason_unemp = $_POST['reason_unemp'];
$next_target_job = $_POST['next_target_job'];

$sql = "INSERT INTO unemployed_lists (previous_job, full_name, age, address, course, date_grad, reason_unemp, next_target_job) VALUES ('$previous_job', '$full_name', $age, '$address', '$course', '$date_grad', '$reason_unemp', '$next_target_job')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
