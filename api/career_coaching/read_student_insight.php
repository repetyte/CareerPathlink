<?php
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

// Check the connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Allow cross-origin requests (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Prepare the SQL query to fetch data from the `student_insight` table
$sql = "SELECT id, gender, appointment_id, total_percentage FROM student_insight";
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
        "gender" => $row["gender"],
        "appointment_id" => $row["appointment_id"],
        "total_percentage" => $row["total_percentage"]
    ];
}

// Return the data as a JSON response
echo json_encode([
    "status" => "success",
    "data" => $data
]);

$mysqli->close();
?>
