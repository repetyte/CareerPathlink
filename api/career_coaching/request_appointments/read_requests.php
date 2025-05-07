<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$database = "final_careercoaching";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    error_log("Database connection failed: " . $conn->connect_error);
    http_response_code(500);
    die(json_encode([
        'success' => false,
        'error' => 'Database connection failed',
        'details' => 'Check server logs for more information'
    ]));
}

try {
    // Query to get pending appointments with service_type
    $sql = "SELECT ra.id, ra.student_name, ra.date_requested, ra.time_requested, 
               '' AS profile_image_url,  -- Empty string as placeholder
               a.coach_id,
               ra.service_type  -- Added service_type
        FROM request_appointments ra
        JOIN appointments a ON ra.appointment_id = a.id
        WHERE ra.status = 'Pending'";
    
    $result = $conn->query($sql);
    
    if ($result === false) {
        error_log("Query failed: " . $conn->error);
        throw new Exception("Failed to retrieve appointment data");
    }
    
    $appointments = [];
    
    while ($row = $result->fetch_assoc()) {
        $appointments[] = [
            'id' => $row['id'],
            'student_name' => $row['student_name'],
            'date_requested' => $row['date_requested'],
            'time_requested' => $row['time_requested'],
            'profile_image_url' => $row['profile_image_url'],
            'coach_id' => $row['coach_id'],
            'service_type' => $row['service_type']  // Added service_type
        ];
    }
    
    // Successful response
    echo json_encode([
        'success' => true,
        'data' => $appointments,
        'count' => count($appointments)
    ]);
    
} catch (Exception $e) {
    error_log("Exception: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'details' => 'An error occurred while processing your request'
    ]);
} finally {
    // Close connection
    if (isset($conn) && $conn instanceof mysqli) {
        $conn->close();
    }
}
?>