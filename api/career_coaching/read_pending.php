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

// SQL query to fetch data from the `pending` table and join it with `appointments` and `slots`
$sql = "SELECT 
            p.id AS pending_id, 
            p.status AS request_status, 
            p.appointment_id, 
            p.program_id, 
            a.coach_id, 
            a.slot_id, 
            a.last_name, 
            a.first_name, 
            a.email, 
            a.phone_no, 
            a.student_no, 
            a.date_of_birth, 
            a.gender, 
            a.year_level, 
            a.department, 
            a.program_id AS appointment_program_id, 
            a.status AS appointment_status,
            s.id AS slot_id, 
            s.date AS slot_date, 
            s.time AS slot_time, 
            s.status AS slot_status, 
            s.slots_available 
        FROM pending p
        JOIN appointments a ON p.appointment_id = a.id
        JOIN slots s ON a.slot_id = s.id
        WHERE a.status = 'Pending'";

$result = $mysqli->query($sql);

// Check for query errors
if ($result === false || $result->num_rows === 0) {
    echo json_encode([
        "status" => "error",
        "message" => $result === false ? "Failed to fetch data: " . $mysqli->error : "No data found",
    ]);
    exit;
}

// Fetch the data and prepare the response
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = [
        "pending_id" => $row["pending_id"],
        "name" => $row["first_name"] . " " . $row["last_name"], // Combined name
        "program" => $row["program_id"],  // Program ID requested
        "date" => $row["slot_date"],  // Date of the requested slot
        "time" => $row["slot_time"],  // Time of the requested slot
        "coach" => $row["coach_id"],  // Coach ID
    ];
}

// Return the data as a JSON response
echo json_encode([
    "status" => "success",
    "data" => $data,
]);

$mysqli->close();
?>
