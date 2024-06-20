<?php
include 'db.php';

$id = $_GET['id'];

$sql = "SELECT * FROM unemployed_lists WHERE id=$id";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode($row);
} else {
    echo "0 results";
}

$conn->close();
?>
