<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'internship_application.php';

$database = new Database();
$db = $database->getConnection();
$opportunity_application = new InternshipApplication($db);

$data = json_decode(file_get_contents("php://input"));

$opportunity_application->application_id = $data->application_id; // Set application_id
$opportunity_application->internship = $data->internship; // Set internship_id
$opportunity_application->applicant_first_name = $data->applicant_first_name;
$opportunity_application->applicant_last_name = $data->applicant_last_name;
$opportunity_application->course = $data->course;
$opportunity_application->applicant_location = $data->applicant_location;
$opportunity_application->applicant_contact_no = $data->applicant_contact_no;
$opportunity_application->applicant_email = $data->applicant_email;
$opportunity_application->resume = $data->resume;
$opportunity_application->cover_letter = $data->cover_letter;
$opportunity_application->skills = $data->skills;
$opportunity_application->certifications = $data->certifications;
$opportunity_application->application_status = $data->application_status;
$opportunity_application->date_applied = $data->date_applied;

if ($opportunity_application->update()) {
    http_response_code(200);
    echo json_encode(array("message" => "Opportunity application was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update opportunity application."));
}