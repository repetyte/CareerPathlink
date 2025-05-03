<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'job_application.php';

$database = new Database();
$db = $database->getConnection();
$job_application = new JobApplication($db);

$data = json_decode(file_get_contents("php://input"));

$job_application->application_id = $data->application_id; // Set application_id
$job_application->job = $data->job;
$job_application->applicant_first_name = $data->applicant_first_name;
$job_application->applicant_last_name = $data->applicant_last_name;
$job_application->degree = $data->degree;
$job_application->applicant_location = $data->applicant_location;
$job_application->applicant_contact_no = $data->applicant_contact_no;
$job_application->applicant_email = $data->applicant_email;
$job_application->resume = $data->resume;
$job_application->cover_letter = $data->cover_letter;
$job_application->skills = $data->skills;
$job_application->certifications = $data->certifications;
$job_application->application_status = $data->application_status;
$job_application->date_applied = $data->date_applied;

if ($job_application->update()) {
    http_response_code(200);
    echo json_encode(array("message" => "Job application was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update job application."));
}