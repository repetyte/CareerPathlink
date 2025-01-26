<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'ccd_acc.php';

$database = new Database();
$db = $database->getConnection();
$account = new CCDAccount($db);

$data = json_decode(file_get_contents("php://input"));

$account->director_id = $data->director_id;
$account->unc_email = $data->unc_email;
$account->first_name = $data->first_name;
$account->middle_name = $data->middle_name;
$account->last_name = $data->last_name;
$account->user_account = $data->user_account;

$account->account_id = $data->account_id;
$account->username = $data->username;
$account->password = $data->password;

if ($account->update()) {
    http_response_code(200);
    echo json_encode(array("message" => "account was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update account."));
}
