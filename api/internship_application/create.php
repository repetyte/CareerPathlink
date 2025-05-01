<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'internship_application.php';

$database = new Database();
$db = $database->getConnection();

$application = new InternshipApplication($db);

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->internship) &&
    !empty($data->applicant_first_name) &&
    !empty($data->applicant_last_name) &&
    !empty($data->applicant_location) &&
    !empty($data->applicant_contact_no) &&
    !empty($data->applicant_email) &&
    !empty($data->resume) &&
    !empty($data->cover_letter) &&
    !empty($data->skills) &&
    !empty($data->certifications) &&
    !empty($data->application_status) &&
    !empty($data->date_applied)
) {
    $application->internship = $data->internship;
    $application->applicant_first_name = $data->applicant_first_name;
    $application->applicant_last_name = $data->applicant_last_name;
    $application->applicant_location = $data->applicant_location;
    $application->applicant_contact_no = $data->applicant_contact_no;
    $application->applicant_email = $data->applicant_email;
    $application->resume = $data->resume;
    $application->cover_letter = $data->cover_letter;
    $application->skills = $data->skills;
    $application->certifications = $data->certifications;
    $application->application_status = $data->application_status;
    $application->date_applied = $data->date_applied;

    if ($application->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "internship application was created."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create internship application."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create internship application. Data is incomplete."));
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

    echo "You have CORS!\n";
}
