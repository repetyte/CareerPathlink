<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include_once 'database.php';
include_once 'job_posting.php';

$database = new Database();
$db = $database->getConnection();
$job = new JobPosting($db);

$data = json_decode(file_get_contents("php://input"));

$job->job_id = $data->job_id;
$job->job_title = $data->job_title;
$job->status = $data->status;
// Assign other fields...

if($job->update()){
    http_response_code(200);
    echo json_encode(array("message" => "Job was updated."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to update job."));
}
?>
