<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'emp_partner_acc.php';

$database = new Database();
$db = $database->getConnection();
$account = new EmpPartnerAccount($db);

$data = json_decode(file_get_contents("php://input"));

$account->partner_name = $data->partner_name;
$account->profile_pic = $data->profile_pic;
$account->partner_location = $data->partner_location;
$account->contact_no = $data->contact_no;
$account->email_add = $data->email_add;
$account->user_account = $data->user_account;
$account->account_id = $data->account_id;
$account->username = $data->username;
$account->password = $data->password;

if ($account->update()) {
    http_response_code(200);
    echo json_encode(array("message" => "Account was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update account."));
}
