<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'job_posting.php';

$database = new Database();
$db = $database->getConnection();

$job = new JobPostingWithPartner($db);

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->cover_photo) &&
    !empty($data->job_title) &&
    !empty($data->status) &&
    !empty($data->field_industry) &&
    !empty($data->job_level) &&
    !empty($data->yrs_of_experience_needed) &&
    !empty($data->contractual_status) &&
    !empty($data->salary) &&
    !empty($data->job_location) &&
    !empty($data->job_description) &&
    !empty($data->requirements) &&
    !empty($data->job_responsibilities) &&
    !empty($data->industry_partner)
) {
    $job->cover_photo = $data->cover_photo;
    $job->job_title = $data->job_title;
    $job->status = $data->status;
    $job->field_industry = $data->field_industry;
    $job->job_level = $data->job_level;
    $job->yrs_of_experience_needed = $data->yrs_of_experience_needed;
    $job->contractual_status = $data->contractual_status;
    $job->salary = $data->salary;
    $job->job_location = $data->job_location;
    $job->job_description = $data->job_description;
    $job->requirements = $data->requirements;
    $job->job_responsibilities = $data->job_responsibilities;
    $job->industry_partner = $data->industry_partner;

    if ($job->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "Job was created."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create job."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create job. Data is incomplete."));
}

function cors(){
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }

    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

        exit(0);
    }

    echo "You have CORS!";
}
