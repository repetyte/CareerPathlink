<?php
$servername = "localhost";
$username = "ccms_db";
$password = "";
$dbname = "ccms_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
