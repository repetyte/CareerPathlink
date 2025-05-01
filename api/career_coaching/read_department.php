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

// SQL query to calculate the overall percentage for each department
$sql = "SELECT 
            d.department AS department_name, 
            SUM(d.percentage) AS overall_percentage
        FROM department d
        GROUP BY d.department";

$result = $mysqli->query($sql);

// Check for query errors
if ($result === false) {
    echo json_encode([
        "status" => "error",
        "message" => "Failed to fetch data: " . $mysqli->error
    ]);
    exit;
}

// Fetch the data and prepare the response
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = [
        "department_name" => $row["department_name"],
        "overall_percentage" => (float) $row["overall_percentage"] // Ensure it's a float
    ];
}

// Return the data as a JSON response
echo json_encode([
    "status" => "success",
    "data" => $data
]);

$mysqli->close();
?>
