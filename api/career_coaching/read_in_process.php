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

// SQL query to fetch data from the `in_process` table and join it with `appointments` and `slots`
$sql = "SELECT 
            ip.id AS in_process_id,
            ip.status AS request_status,
            ip.appointment_id,
            ip.program_request,
            s.date AS date_request,
            s.time AS time_request,
            a.last_name,
            a.first_name,
            a.email,
            a.phone_no,
            a.student_no,
            a.date_of_birth,
            a.gender,
            a.year_level,
            a.department
        FROM in_process ip
        JOIN appointments a ON ip.appointment_id = a.id
        JOIN slots s ON s.date = ip.date_request AND s.time = ip.time_request
        WHERE ip.status = 'In Process'";

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
        "in_process_id" => $row["in_process_id"],
        "name" => $row["first_name"] . " " . $row["last_name"], // Combined name
        "program_request" => $row["program_request"],
        "date_request" => $row["date_request"],
        "time_request" => $row["time_request"],
        "email" => $row["email"],
        "phone_no" => $row["phone_no"],
        "student_no" => $row["student_no"],
        "gender" => $row["gender"],
        "year_level" => $row["year_level"],
        "department" => $row["department"],
    ];
}

// Return the data as a JSON response
echo json_encode([
    "status" => "success",
    "data" => $data,
]);

$mysqli->close();
?>
