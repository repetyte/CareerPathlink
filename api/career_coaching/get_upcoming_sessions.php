<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Database connection
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

if ($mysqli->connect_error) {
    echo json_encode(["error" => "Database connection failed: " . $mysqli->connect_error]);
    exit;
}

$query = "
    SELECT p.program_name AS session_name, us.session_date, us.session_time
    FROM upcoming_sessions us
    JOIN appointments a ON us.appointment_id = a.id
    JOIN programs p ON a.program_id = p.id
";

$result = $mysqli->query($query);

if (!$result) {
    echo json_encode(["error" => "Query failed: " . $mysqli->error]);
    exit;
}

$sessions = [];
while ($row = $result->fetch_assoc()) {
    $sessions[] = [
        'session_name' => $row['session_name'],
        'session_date' => $row['session_date'],
        'session_time' => $row['session_time']
    ];
}

echo json_encode(['data' => $sessions]);

$mysqli->close();
?>
