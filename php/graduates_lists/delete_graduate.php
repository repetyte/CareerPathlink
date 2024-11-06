<?php
include 'db.php';

$grad_id = $_POST['grad_id'];

$sql = "DELETE FROM graduates_lists WHERE grad_id=$grad_id";

if ($conn->query($sql) === TRUE) {
    echo "Record deleted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
