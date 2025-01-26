<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['student_no'])) {
    $query = "UPDATE employed_lists SET 
              last_name = :last_name,
              first_name = :first_name,
              middle_name = :middle_name,
              birthdate = :birthdate,
              age = :age,
              home_address = :home_address,
              unc_email = :unc_email,
              personal_email = :personal_email,
              facebook_name = :facebook_name,
              course = :course,
              `1st_target_employer` = :first_target_employer,
              `2nd_target_employer` = :second_target_employer,
              `3rd_target_employer` = :third_target_employer,
              graduation_date = :graduation_date
              WHERE student_no = :student_no";

    $stmt = $conn->prepare($query);
    $stmt->execute([
        ':student_no' => $data['student_no'],
        ':last_name' => $data['last_name'],
        ':first_name' => $data['first_name'],
        ':middle_name' => $data['middle_name'],
        ':birthdate' => $data['birthdate'],
        ':age' => $data['age'],
        ':home_address' => $data['home_address'],
        ':unc_email' => $data['unc_email'],
        ':personal_email' => $data['personal_email'],
        ':facebook_name' => $data['facebook_name'],
        ':course' => $data['course'],
        ':first_target_employer' => $data['1st_target_employer'],
        ':second_target_employer' => $data['2nd_target_employer'],
        ':third_target_employer' => $data['3rd_target_employer'],
        ':graduation_date' => $data['graduation_date'] // Added graduation_date
    ]);

    echo json_encode(["message" => "Graduate updated successfully"]);
} else {
    http_response_code(400);
    echo json_encode(["message" => "Invalid data"]);
}
?>
