<?php
include 'db.php';

$graduate_id = $_POST['graduate_id'];

$sql = "DELETE FROM graduates_lists WHERE graduate_id=$graduate_id";

if ($conn->query($sql) === TRUE) {
    echo "Record deleted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
