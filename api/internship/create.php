<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

cors();

include_once '../database.php';
include_once 'internship.php';

$database = new Database();
$db = $database->getConnection();

$internship = new InternshipWithPartner($db);

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->display_photo) &&
    !empty($data->internship_title) &&
    !empty($data->description) &&
    !empty($data->required_skills) &&
    !empty($data->qualifications) &&
    !empty($data->additional_skills) &&
    !empty($data->industry_partner)
) {
    $internship->display_photo = $data->display_photo;
    $internship->internship_title = $data->internship_title;
    $internship->description = $data->description;
    $internship->required_skills = $data->required_skills;
    $internship->qualifications = $data->qualifications;
    $internship->additional_skills = $data->additional_skills;
    $internship->industry_partner = $data->industry_partner;

    if ($internship->create()) {
        http_response_code(201);
        echo json_encode(array("message" => "Internship was created."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create internship."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Unable to create internship. Data is incomplete."));
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