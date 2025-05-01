<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$mysqli = new mysqli("localhost", "root", "", "ccms_db");

if ($mysqli->connect_error) {
    echo json_encode(["error" => "Database connection failed: " . $mysqli->connect_error]);
    exit;
}

$query = "
    SELECT p.program_name AS session_name, ps.session_date, ps.session_time, ps.completed_at, ps.feedback, ps.program
    FROM past_sessions ps
    JOIN appointments a ON ps.appointment_id = a.id
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
        'session_time' => $row['session_time'],
        'completed_at' => $row['completed_at'],
        'feedback' => $row['feedback'],
        'program' => $row['program']
    ];
}

echo json_encode(['data' => $sessions]);

$mysqli->close();
?>
