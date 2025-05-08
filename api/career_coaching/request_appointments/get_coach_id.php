<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$database = "ccms_db";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    echo json_encode(["error" => "Database Connection Failed: " . $conn->connect_error]);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    if (!isset($_GET['id'])) {
        echo json_encode(["error" => "Coach ID is required"]);
        exit();
    }

    $coach_id = $conn->real_escape_string($_GET['id']);

    $sql = "SELECT id, coach_name, user_id FROM coaches WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $coach_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo json_encode(["error" => "Coach not found"]);
        exit();
    }

    $coach = $result->fetch_assoc();
    echo json_encode($coach);
    exit();
}

$conn->close();
?>