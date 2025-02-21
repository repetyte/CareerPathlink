<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'employed_lists.php';

$database = new Database();
$db = $database->getConnection();

$employed_grad = new EmployedLists($db);

$data = json_decode(file_get_contents("php://input"));
error_log("Received Data: " . json_encode($data)); // Log the received data

if (
    !(empty($data->employed_grad_id)) &&
    !(empty($data->graduate)) &&
    !empty($data->job_title) &&
    !empty($data->company_name) &&
    !empty($data->company_address) &&
    !empty($data->position) &&
    !empty($data->start_date) &&
    !empty($data->basic_salary)
) {
    $employed_grad->employed_grad_id = $data->employed_grad_id;
    $employed_grad->graduate = $data->graduate;
    $employed_grad->job_title = $data->job_title;
    $employed_grad->company_name = $data->company_name;
    $employed_grad->company_address = $data->company_address;
    $employed_grad->position = $data->position;
    $employed_grad->start_date = $data->start_date;
    $employed_grad->basic_salary = $data->basic_salary;

    if ($employed_grad->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "Employed Graduate was created."));
    } else {
        error_log("Create method failed."); // Log the failure
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create employed graduate."));
    }
} else {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    error_log("Incomplete data: " . json_encode($data)); // Log incomplete data
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create employed graduate. Data is incomplete."));
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

