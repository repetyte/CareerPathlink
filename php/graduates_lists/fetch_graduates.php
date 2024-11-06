<?php
include 'db.php';

$department = $_GET['department'];

$sql = "SELECT * FROM graduates_lists WHERE course='$department'";
$result = $conn->query($sql);

$graduates = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $graduates[] = $row;
    }
}

echo json_encode($graduates);

$conn->close();
?>
