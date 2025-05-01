<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../database.php';
include_once 'employed_lists.php';

$database = new Database();
$db = $database->getConnection();

$employed_lists = new EmployedLists($db);

$stmt = $employed_lists->read();
$num = $stmt->rowCount();

if($num > 0){
    $employed_lists_arr = array();
    $employed_lists_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $employed_lists_item = array(
            "employed_grad_id" => $employed_grad_id,
            "graduate" => $graduate,
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
            "department" => $department,
            "first_target_employer" => $first_target_employer,
            "second_target_employer" => $second_target_employer,
            "third_target_employer" => $third_target_employer,
            "job_title" => $job_title,
            "company_name" => $company_name,
            "company_address" => $company_address,
            "position" => $position,
            "start_date" => $start_date,
            "basic_salary" => $basic_salary
        );

        array_push($employed_lists_arr["records"], $employed_lists_item);
    }

    http_response_code(200);
    echo json_encode($employed_lists_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No Graduates Lists found."));
}
