<?php
$servername = "localhost";
$username = "root"; // default username for MySQL in Laragon
$password = ""; // default password for MySQL in Laragon (empty)
$dbname = "sheduling_system"; // name of your database

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
