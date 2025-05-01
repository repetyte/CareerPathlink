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

// Query to fetch pending requests
$query = "
    SELECT 
        r.appointment_id,
        r.name,
        r.program,
        r.date,
        r.time
    FROM requests r
    WHERE r.status = 'pending'
";

$result = $mysqli->query($query);

if (!$result) {
    echo json_encode(["error" => "Query failed: " . $mysqli->error]);
    exit;
}

$pendingRequests = [];
while ($row = $result->fetch_assoc()) {
    $pendingRequests[] = [
        'appointment_id' => $row['appointment_id'], // Appointment ID
        'name' => $row['name'], // Name of the requester
        'program' => $row['program'], // Program requested
        'date' => $row['date'], // Date of request
        'time' => $row['time'], // Time of request
    ];
}

// Return data as JSON
echo json_encode(['status' => 'success', 'data' => $pendingRequests]);

$mysqli->close();
?>
