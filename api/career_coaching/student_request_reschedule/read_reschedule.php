<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$database = "final_careercoaching";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    echo json_encode(["error" => "Database Connection Failed: " . $conn->connect_error]);
    exit;
}

$conn->set_charset("utf8");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $appointmentId = isset($_GET['appointment_id']) ? $_GET['appointment_id'] : null;
    
    if ($appointmentId) {
        // Query for specific appointment
        $stmt = $conn->prepare("SELECT rr.*, a.service_type 
                  FROM reschedule_requests rr
                  JOIN appointments a ON rr.appointment_id = a.id
                  WHERE rr.appointment_id = ?");
        $stmt->bind_param("i", $appointmentId);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        // Query all requests
        $query = "SELECT rr.*, a.service_type 
              FROM reschedule_requests rr
              JOIN appointments a ON rr.appointment_id = a.id";
        $result = $conn->query($query);
    }
    
    if ($result && $result->num_rows > 0) {
        $reschedule_requests = [];
        while ($row = $result->fetch_assoc()) {
            $reschedule_requests[] = $row;
        }
        echo json_encode($reschedule_requests);
    } else {
        echo json_encode([]);
    }
} else {
    echo json_encode(["error" => "Invalid request method. Use GET."]);
}

$conn->close();
?>