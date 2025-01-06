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

// Decode incoming JSON data
$data = json_decode(file_get_contents("php://input"), true);

// Log incoming data for debugging
file_put_contents('php://stderr', "Incoming data: " . print_r($data, true));
file_put_contents('php://stderr', "Gender: " . $data['gender'] . "\n");
file_put_contents('php://stderr', "Department: " . $data['department'] . "\n");

// Check if JSON is properly decoded
if (!$data) {
    echo json_encode(["status" => "error", "message" => "Invalid JSON data"]);
    exit;
}

// Check for missing fields (null or empty values)
if (empty($data['gender']) || empty($data['department'])) {
    echo json_encode(["status" => "error", "message" => "Gender or Department is missing"]);
    exit;
}

// Prepare the SQL statement to insert the appointment
$stmt = $mysqli->prepare(
    "INSERT INTO appointments (
        coach_id, slot_id, last_name, suffix, first_name, middle_name, 
        email, phone_no, student_no, date_of_birth, gender, 
        year_level, department, program_id
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
);

// Error logging if preparation fails
if ($stmt === false) {
    file_put_contents('php://stderr', "Failed to prepare statement: " . $mysqli->error);
    echo json_encode([
        "status" => "error",
        "message" => "Failed to prepare statement: " . $mysqli->error
    ]);
    exit;
}

// Bind parameters to the SQL statement
if (!$stmt->bind_param(
    "iissssssssssss", // Make sure this matches the number of parameters (14 variables)
    $data['coach_id'],
    $data['slot_id'],
    $data['last_name'],
    $data['suffix'],
    $data['first_name'],
    $data['middle_name'],
    $data['email'],
    $data['phone_no'],
    $data['student_no'],
    $data['date_of_birth'],
    $data['gender'],   // Ensure this is a string
    $data['year_level'],
    $data['department'], // Ensure this is a string
    $data['program_id']
)) {
    file_put_contents('php://stderr', "Failed to bind parameters: " . $stmt->error);
    echo json_encode(["status" => "error", "message" => "Failed to bind parameters"]);
    exit;
}

// Execute the statement and handle the result
if ($stmt->execute()) {
    // Get the ID of the inserted row
    $appointmentId = $mysqli->insert_id;
    echo json_encode([
        "status" => "success",
        "appointment_id" => $appointmentId
    ]);
} else {
    // Log the error if the query fails
    file_put_contents('php://stderr', "Failed to execute statement: " . $stmt->error);
    echo json_encode([
        "status" => "error",
        "message" => "Failed to add appointment: " . $stmt->error
    ]);
}

$stmt->close();
$mysqli->close();
?>
