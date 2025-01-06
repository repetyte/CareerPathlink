<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// Create a connection to the database
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // Get the student number from the query string
    $student_no = isset($_GET['student_no']) ? $_GET['student_no'] : '';

    // If student number is provided
    if ($student_no) {
        // Prepare the SQL query
        $query = $mysqli->prepare("SELECT * FROM student_profile WHERE student_no = ?");
        $query->bind_param("s", $student_no);
        
        // Debugging: log the SQL query and parameters
        file_put_contents('php://stderr', "Query: SELECT * FROM student_profile WHERE student_no = $student_no\n");

        $query->execute();
        $result = $query->get_result();

        if ($result->num_rows > 0) {
            // Fetch the student data
            $student = $result->fetch_assoc();
            echo json_encode($student); // Return the student data as JSON
        } else {
            // Return an error message if the student is not found
            echo json_encode(['error' => 'Student not found']);
        }
    } else {
        // Return an error message if the student number is not provided
        echo json_encode(['error' => 'Student number is required']);
    }
}

$mysqli->close(); // Close the database connection
?>
