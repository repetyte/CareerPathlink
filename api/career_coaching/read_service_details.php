<?php
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

// Check the connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Allow cross-origin requests (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// SQL query to join `service_details` with the `programs` table and get `program_name`
$sql = "SELECT s.id, p.program_name, s.appointment_id, s.percentage 
        FROM service_details s
        JOIN programs p ON s.program_id = p.id";

$result = $mysqli->query($sql);

// Check for query errors
if ($result === false) {
    echo json_encode([
        "status" => "error",
        "message" => "Failed to fetch data: " . $mysqli->error
    ]);
    exit;
}

// Fetch the data and prepare the response
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = [
        "id" => $row["id"],
        "program_name" => $row["program_name"],  // Use `program_name`
        "appointment_id" => $row["appointment_id"],
        "percentage" => $row["percentage"]  // Use `percentage`
    ];
}

// Return the data as a JSON response
echo json_encode([
    "status" => "success",
    "data" => $data
]);

$mysqli->close();
?>
