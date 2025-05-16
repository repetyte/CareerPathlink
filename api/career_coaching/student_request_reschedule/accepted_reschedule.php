<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "localhost";
$username = "root";
$password = "";
$database = "ccms_db";

// Connect to MySQL
$conn = new mysqli($servername, $username, $password, $database);

// Check for connection error
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Database Connection Failed: " . $conn->connect_error]);
    exit;
}

// Set character set to UTF-8
$conn->set_charset("utf8");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Validate input data
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Get raw JSON input
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        http_response_code(400);
        echo json_encode(["error" => "Invalid JSON input"]);
        exit;
    }

    // Validate required fields
    if (!isset($data['id']) || empty($data['id'])) {
        http_response_code(400);
        echo json_encode(["error" => "Reschedule Request ID is required"]);
        exit;
    }
    if (!isset($data['coach_id']) || empty($data['coach_id'])) {
        http_response_code(400);
        echo json_encode(["error" => "Coach ID is required"]);
        exit;
    }

    // Sanitize input data
    $id = $conn->real_escape_string($data['id']);
    $coach_id = $conn->real_escape_string($data['coach_id']);
    $coach_reply = isset($data['coach_reply']) ? $conn->real_escape_string($data['coach_reply']) : '';
    
    // Update reschedule request in the database
    $update_query = "UPDATE reschedule_requests 
                    SET status = 'Accepted', 
                        coach_reply = '$coach_reply', 
                        reply_date = NOW(), 
                        reply_by = '$coach_id' 
                    WHERE id = '$id'";

    if ($conn->query($update_query) === TRUE) {
        http_response_code(200);
        echo json_encode([
            // "success" => "Reschedule request accepted successfully",
             "success" => true,
            "updated_fields" => [
                "status" => "Accepted",
                "coach_reply" => $coach_reply,
                "reply_date" => date("Y-m-d H:i:s"),
                "reply_by" => $coach_id
            ]
        ]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Failed to accept reschedule request: " . $conn->error]);
    }
} else {
    http_response_code(405);
    echo json_encode(["error" => "Invalid request method. Use PUT."]);
}

$conn->close();
?>