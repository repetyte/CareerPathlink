<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '..\database.php';
include_once 'internship_application.php';

$database = new Database();
$db = $database->getConnection();

$internship_application = new InternshipApplication($db);

$stmt = $internship_application->read();
$num = $stmt->rowCount();

if($num > 0){
    $internship_applications_arr = array();
    $internship_applications_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $internship_application_item = array(
            "application_id" => $application_id,
            "internship" => $internship,
            "applicant_first_name" => $applicant_first_name,
            "applicant_last_name" => $applicant_last_name,
            "applicant_location" => $applicant_location,
            "applicant_contact_no" => $applicant_contact_no,
            "applicant_email" => $applicant_email,
            "resume" => $resume,
            "cover_letter" => $cover_letter,
            "skills" => $skills,
            "certifications" => $certifications,
            "application_status" => $application_status,
            "date_applied" => $date_applied,

            // from internship_tb
            "internship_id" => $internship_id,
            "display_photo" => $display_photo,
            "internship_title" => $internship_title,
            "hours" => $hours,
            "takehome_pay" => $takehome_pay,
            "location" => $location,
            "description" => $description,
            "required_skills" => $required_skills,
            "qualifications" => $qualifications,
            "industry_partner" => $industry_partner
        );

        array_push($internship_applications_arr["records"], $internship_application_item);
    }

    http_response_code(200);
    echo json_encode($internship_applications_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No internship application found. Solve tihis on 'internship_application/read.php'.\n"));
}