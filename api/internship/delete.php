<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'internship.php';

$database = new Database();
$db = $database->getConnection();
$internship = new InternshipWithPartner($db);

$data = json_decode(file_get_contents("php://input"));

$internship->internship_id = $data->internship_id;

if($internship->delete()){
    http_response_code(200);
    echo json_encode(array("message" => "Internship was deleted."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to delete internship."));
}