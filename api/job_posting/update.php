<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../database.php';
include_once 'job_posting.php';

$database = new Database();
$db = $database->getConnection();
$job = new JobPostingWithPartner($db);

$data = json_decode(file_get_contents("php://input"));

$job->job_id = $data->job_id;
$job->cover_photo = $data->cover_photo;
$job->job_title = $data->job_title;
$job->status = $data->status;
$job->field_industry = $data->field_industry;
$job->job_level = $data->job_level;
$job->yrs_of_experience_needed = $data->yrs_of_experience_needed;
$job->contractual_status = $data->contractual_status;
$job->salary = $data->salary;
$job->job_location  = $data->job_location;
$job->job_description = $data->job_description;
$job->requirements = $data->requirements;
$job->job_responsibilities = $data->job_responsibilities;
$job->industry_partner = $data->industry_partner;

if($job->update()){
    http_response_code(200);
    echo json_encode(array("message" => "Job was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update job."));
}
?>
