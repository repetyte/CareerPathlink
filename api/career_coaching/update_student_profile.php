<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// Create a connection to the database
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the data from the request body
    $data = json_decode(file_get_contents("php://input"));

    // Debugging: log incoming data
    file_put_contents('php://stderr', print_r($data, true)); // Log data to stderr

    // Check if student number is provided
    if (isset($data->student_no)) {
        // Assign variables to data fields
        $student_no = $data->student_no;
        $name = $data->name;
        $department = $data->department;
        $course = $data->course;
        $level = $data->level;
        $address = $data->address;
        $contact = $data->contact;
        $email = $data->email;
        $password = $data->password;

        // Use prepared statements to prevent SQL injection
        $query = $mysqli->prepare("UPDATE student_profile SET name = ?, department = ?, course = ?, level = ?, address = ?, contact = ?, email = ?, password = ? WHERE student_no = ?");
        $query->bind_param("sssssssss", $name, $department, $course, $level, $address, $contact, $email, $password, $student_no);

        // Execute the query and check for errors
        if ($query->execute()) {
            echo json_encode(['success' => 'Student information updated successfully']);
        } else {
            echo json_encode(['error' => 'Error updating student information', 'details' => $mysqli->error]);
        }
    } else {
        // Return an error if student number is not provided
        echo json_encode(['error' => 'Student number is required']);
    }
}

$mysqli->close(); // Close the database connection
?>
