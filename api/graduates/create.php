<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'graduates_lists.php';

$database = new Database();
$db = $database->getConnection();

$job = new GraduatesLists($db);

$data = json_decode(file_get_contents("php://input"));
error_log("Received Data: " . json_encode($data)); // Log the received data

if (
    !empty($data->student_no) &&
    !empty($data->last_name) &&
    !empty($data->first_name) &&
    !empty($data->middle_name) &&
    !empty($data->birthdate) &&
    !empty($data->age) &&
    !empty($data->home_address) &&
    !empty($data->unc_email) &&
    !empty($data->personal_email) &&
    !empty($data->facebook_name) &&
    !empty($data->graduation_date) &&
    !empty($data->course) &&
    !empty($data->department) &&
    !empty($data->first_target_employer) &&
    !empty($data->second_target_employer) &&
    !empty($data->third_target_employer)
) {
    $job->student_no = $data->student_no;
    $job->last_name = $data->last_name;
    $job->first_name = $data->first_name;
    $job->middle_name = $data->middle_name;
    $job->birthdate = $data->birthdate;
    $job->age = $data->age;
    $job->home_address = $data->home_address;
    $job->unc_email = $data->unc_email;
    $job->personal_email = $data->personal_email;
    $job->facebook_name = $data->facebook_name;
    $job->graduation_date = $data->graduation_date;
    $job->course = $data->course;
    $job->department = $data->department;
    $job->first_target_employer = $data->first_target_employer;
    $job->second_target_employer = $data->second_target_employer;
    $job->third_target_employer = $data->third_target_employer;

    if ($job->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "Graduate was created."));
    } else {
        error_log("Create method failed."); // Log the failure
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create graduate."));
    }
} else {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    error_log("Incomplete data: " . json_encode($data)); // Log incomplete data
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create graduate. Data is incomplete."));
}

function cors(){
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }

    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

        exit(0);
    }

    echo "You have CORS!";
}
