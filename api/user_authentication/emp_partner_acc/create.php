<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'emp_partner_acc.php';

$database = new Database();
$db = $database->getConnection();

$account = new EmpPartnerAccount($db);

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->partner_id) &&
    !empty($data->profile_pic) &&
    !empty($data->partner_name) &&
    !empty($data->partner_location) &&
    !empty($data->contact_no) &&
    !empty($data->email_add) &&
    !empty($data->user_account)
) {
    $account->partner_id = $data->partner_id;
    $account->profile_pic = $data->profile_pic;
    $account->partner_name = $data->partner_name;
    $account->partner_location = $data->partner_location;
    $account->contact_no = $data->contact_no;
    $account->email_add = $data->email_add;
    $account->user_account = $data->user_account;

    if ($account->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "Account was created."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create account."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create account. Data is incomplete."));
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
