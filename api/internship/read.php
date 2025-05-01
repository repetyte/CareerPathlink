<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../database.php';
include_once 'internship.php';

$database = new Database();
$db = $database->getConnection();

$internship = new InternshipWithPartner($db);

$stmt = $internship->read();
$num = $stmt->rowCount();

if($num > 0){
    $internships_arr = array();
    $internships_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $internship_item = array(
            "internship_id" => $internship_id,
            "display_photo" => $display_photo,
            "internship_title" => $internship_title,
            "takehome_pay" => $takehome_pay,
            "location" => $location,
            "description" => $description,
            "required_skills" => $required_skills,
            "qualifications" => $qualifications,
            "hours" => $hours,
            "industry_partner" => $industry_partner,
            "partner_id" => $partner_id,
            "profile_pic" => $profile_pic,
            "partner_name" => $partner_name,
            "partner_location" => $partner_location,
            "contact_no" => $contact_no,
            "email_add" => $email_add,
        );

        array_push($internships_arr["records"], $internship_item);
    }

    http_response_code(200);
    echo json_encode($internships_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No internships found."));
}