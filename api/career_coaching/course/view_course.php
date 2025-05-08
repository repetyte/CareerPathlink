<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$database = "ccms_db";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    echo json_encode(["error" => "Database Connection Failed: " . $conn->connect_error]);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $sql = "SELECT 
                course,
                total_students,
                active_students,
                total_appointments,
                completed_appointments,
                cancelled_appointments,
                pending_appointments,
                engagement_rate,
                completion_rate
            FROM vw_course_engagement
            ORDER BY engagement_rate DESC";

    $result = $conn->query($sql);

    if ($result) {
        $courses = [];
        while ($row = $result->fetch_assoc()) {
            $courses[] = [
                'course' => $row['course'] ?? 'Unknown',
                'total_students' => (int)($row['total_students'] ?? 0),
                'active_students' => (int)($row['active_students'] ?? 0),
                'total_appointments' => (int)($row['total_appointments'] ?? 0),
                'completed_appointments' => (int)($row['completed_appointments'] ?? 0),
                'cancelled_appointments' => (int)($row['cancelled_appointments'] ?? 0),
                'pending_appointments' => (int)($row['pending_appointments'] ?? 0),
                'engagement_rate' => (float)($row['engagement_rate'] ?? 0),
                'completion_rate' => (float)($row['completion_rate'] ?? 0)
            ];
        }

        echo json_encode([
            'success' => true,
            'data' => $courses,
            'count' => count($courses)
        ]);
    } else {
        echo json_encode([
            'error' => true,
            'message' => 'Error fetching course engagement data: ' . $conn->error
        ]);
    }
} else {
    echo json_encode(["error" => "Invalid request method. Use GET to fetch course engagement data"]);
}

$conn->close();
?>