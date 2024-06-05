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

if($job->delete()){
    http_response_code(200);
    echo json_encode(array("message" => "Job was deleted."));
} else {
    http_response_code(503);
    echo json_encode(array("message" => "Unable to delete job."));
}
?>
