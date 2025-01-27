<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../database.php';
include_once 'graduates_lists.php';

$database = new Database();
$db = $database->getConnection();

$graduates_lists = new GraduatesLists($db);

$stmt = $graduates_lists->read();
$num = $stmt->rowCount();

if($num > 0){
    $graduates_lists_arr = array();
    $graduates_lists_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $graduates_lists_item = array(
            "student_no" => $student_no,
            "last_name" => $last_name,
            "first_name" => $first_name,
            "middle_name" => $middle_name,
            "birthdate" => $birthdate,
            "age" => $age,
            "home_address" => $home_address,
            "unc_email" => $unc_email,
            "personal_email" => $personal_email,
            "facebook_name" => $facebook_name,
            "graduation_date" => $graduation_date,
            "course" => $course,
            "first_target_employer" => $first_target_employer,
            "second_target_employer" => $second_target_employer,
            "third_target_employer" => $third_target_employer,
            
        );

        array_push($graduates_lists_arr["records"], $graduates_lists_item);
    }

    http_response_code(200);
    echo json_encode($graduates_lists_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No Graduates Lists found."));
}