<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'internship.php';

$database = new Database();
$db = $database->getConnection();
$internship = new InternshipWithPartner($db);

$data = json_decode(file_get_contents("php://input"));

$internship->internship_id = $data->internship_id; // Set internship_id
$internship->display_photo = $data->display_photo;
$internship->internship_title = $data->internship_title;
$internship->hours = $data->hours;
$internship->takehome_pay = $data->takehome_pay;
$internship->location = $data->location;
$internship->description = $data->description;
$internship->required_skills = $data->required_skills;
$internship->qualifications = $data->qualifications;
$internship->industry_partner = $data->industry_partner;

// Partner details
$internship->profile_pic = $data->profile_pic;
$internship->partner_name = $data->partner_name;
$internship->partner_location = $data->partner_location;
$internship->contact_no = $data->contact_no;
$internship->email_add = $data->email_add;

if ($internship->update()) {
    http_response_code(200);
    echo json_encode(array("message" => "WIL Opportunity was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update internship."));
}