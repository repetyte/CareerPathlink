<?php
// Database configuration
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'final_careercoaching');

// Create connection
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Set headers for API
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', 'error_log.txt');

// Handle GET request to fetch department engagement data
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        $query = "SELECT * FROM vw_department_engagement";
        $result = $conn->query($query);
        
        if (!$result) {
            throw new Exception("Error executing query: " . $conn->error);
        }
        
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        
        // Return JSON response
        echo json_encode([
            'success' => true,
            'data' => $data,
            'message' => 'Department engagement data retrieved successfully'
        ]);
        
    } catch (Exception $e) {
        // Return error response
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
    }
} else {
    // Return method not allowed
    http_response_code(405);
    echo json_encode([
        'success' => false,
        'message' => 'Method not allowed'
    ]);
}

// Close connection
$conn->close();
?>