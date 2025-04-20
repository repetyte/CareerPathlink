<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');


include_once '../../database.php';
include_once 'graduate_acc.php';

$database = new Database();
$db = $database->getConnection();

$account = new GraduateAccount($db);

$stmt = $account->read();
$num = $stmt->rowCount();

if($num > 0){
    $accounts_arr = array();
    $accounts_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $account_item = array(
            "graduate_id" => $graduate_id,
            "email" => $email,
            "first_name" => $first_name,
            "middle_name" => $middle_name,
            "last_name" => $last_name,
            "course" => $course,
            "department" => $department,
            "bday" => $bday,
            "gender" => $gender,
            "age" => $age,
            "address" => $address,
            "contact_no" => $contact_no,
            "date_grad" => $date_grad,
            "emp_stat" => $emp_stat,
            "user_account" => $user_account,
            "account_id" => $account_id,
            "username" => $username,
            "password" => $password,
            "resume" => $resume,
            "skills" => $skills,
            "certifications" => $certifications,
        );

        array_push($accounts_arr["records"], $account_item);
    }

    http_response_code(200);
    echo json_encode($accounts_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No jobs found."));
}