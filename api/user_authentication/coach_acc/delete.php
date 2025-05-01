<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'ccd_acc.php';

$database = new Database();
$db = $database->getConnection();
$account = new CCDAccount($db);

$data = json_decode(file_get_contents("php://input"));

$account->director_id = $data->director_id;

if($account->delete()){
    http_response_code(200);
    echo json_encode(array("message" => "Career Center Account was deleted."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to delete account."));
}