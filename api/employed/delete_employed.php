<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['student_no'])) {
    $query = "DELETE FROM employed_lists WHERE student_no = :student_no";

    $stmt = $conn->prepare($query);
    $stmt->execute([':student_no' => $data['student_no']]);

    echo json_encode(["message" => "Employed record deleted successfully"]);
} else {
    http_response_code(400);
    echo json_encode(["message" => "Invalid data"]);
}
?>
