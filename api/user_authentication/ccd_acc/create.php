<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'ccd_acc.php';

$database = new Database();
$db = $database->getConnection();

$account = new CCDAccount($db);

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->director_id) &&
    !empty($data->unc_email) &&
    !empty($data->first_name) &&
    !empty($data->middle_name) &&
    !empty($data->last_name) &&
    !empty($data->user_account)
) {
    $account->director_id = $data->director_id;
    $account->unc_email = $data->unc_email;
    $account->first_name = $data->first_name;
    $account->middle_name = $data->middle_name;
    $account->last_name = $data->last_name;
    $account->user_account = $data->user_account;

    if ($account->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "account was created."));
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
