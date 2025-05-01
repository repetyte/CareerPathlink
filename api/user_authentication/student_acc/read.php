<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../database.php';
include_once 'student_acc.php';

$database = new Database();
$db = $database->getConnection();

$student = new StudentAccount($db);

$stmt = $student->read();
$num = $stmt->rowCount();

if($num > 0){
    $students_arr = array();
    $students_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $student_item = array(
            "student_id" => $student_id,
            "first_name" => $first_name,
            "middle_name" => $middle_name,
            "last_name" => $last_name,
            "email" => $email,
            "course" => $course,
            "department" => $department,
            "contact_no" => $contact_no,
            "bday" => $bday,
            "gender" => $gender,
            "age" => $age,
            "address" => $address,
            
            "user_account" => $user_account,
            "account_id" => $account_id,
            "username" => $username,
            "password" => $password,
            "resume" => $resume,
            "skills" => $skills,
            "certifications" => $certifications,
        );

        array_push($students_arr["records"], $student_item);
    }

    http_response_code(200);
    echo json_encode($students_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No students found."));
}