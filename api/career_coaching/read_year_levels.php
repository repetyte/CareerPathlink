<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Database connection
$mysqli = new mysqli("localhost", "root", "", "ccms_db");

if ($mysqli->connect_error) {
    echo json_encode(["error" => "Database connection failed: " . $mysqli->connect_error]);
    exit;
}

// Query to calculate the overall average percentage for each year level
$query = "
    SELECT 
        yl.year_level,
        AVG(yl.percentage) AS overall_percentage
    FROM year_levels yl
    GROUP BY yl.year_level
";

$result = $mysqli->query($query);

if (!$result) {
    echo json_encode(["error" => "Query failed: " . $mysqli->error]);
    exit;
}

$yearLevels = [];
while ($row = $result->fetch_assoc()) {
    $yearLevels[] = [
        'year_level' => $row['year_level'],  // Year level (e.g., "1st Year")
        'percentage' => (float)$row['overall_percentage'], // Average percentage for that year level
    ];
}

// Return data as JSON
echo json_encode(['data' => $yearLevels]);

$mysqli->close();
?>
