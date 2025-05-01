
<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
// Connect to the database
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

// Check for connection error
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Check if coach_id is provided
if (isset($_GET['coach_id'])) {
    $coach_id = $_GET['coach_id'];

    // Prepare the SQL query to fetch all slots (both available and booked) for the given coach_id
    $stmt = $mysqli->prepare("SELECT id, coach_id, date, time, status FROM slots WHERE coach_id = ?");
    
    // Check if preparing the statement failed
    if ($stmt === false) {
        die("Error preparing the SQL query: " . $mysqli->error);
    }

    // Bind the coach_id parameter to the prepared statement (assuming it's an integer)
    $stmt->bind_param("i", $coach_id); // "i" means integer

    // Execute the prepared statement
    if (!$stmt->execute()) {
        file_put_contents('php://stderr', "Error executing query: " . $stmt->error);
    }
    

    // Get the result of the query
    $result = $stmt->get_result();

    // Check if any rows are returned
    if ($result->num_rows > 0) {
        // Initialize an array to hold the slots
        $slots = [];
        
        // Fetch the rows and add them to the array
        while ($row = $result->fetch_assoc()) {
            $slots[] = $row;
        }

        // Return the slots in JSON format
        echo json_encode($slots);
    } else {
        // If no rows are found, return an empty array
        echo json_encode([]);
    }

    // Close the prepared statement
    $stmt->close();
} else {
    // If coach_id is not provided, return an error message
    echo json_encode(["error" => "coach_id parameter is missing."]);
}

// Close the MySQL connection
$mysqli->close();
?>
