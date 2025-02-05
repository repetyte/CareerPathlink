<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '..\database.php';
include_once 'job_application.php';

$database = new Database();
$db = $database->getConnection();

$job_application = new JobApplication($db);

$stmt = $job_application->read();
$num = $stmt->rowCount();

if($num > 0){
    $job_applications_arr = array();
    $job_applications_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $job_application_item = array(
            "application_id" => $application_id,
            "applicant" => $applicant,
            "job" => $job,
            "resume" => $resume,
            "cover_letter" => $cover_letter,
            "skills" => $skills,
            "certifications" => $certifications,
            "application_status" => $application_status,
            "date_applied" => $date_applied,

            // from graduates_tb
            "graduate_id" => $graduate_id,
            "email" => $email,
            "first_name" => $first_name,
            "middle_name" => $middle_name,
            "last_name" => $last_name,
            "course" => $course,
            "department" => $department,
            "bday" => $bday,
            "gender" => $gender,
            "age" => $age,
            "address" => $address,
            "contact_no" => $contact_no,
            "date_grad" => $date_grad,
            "emp_stat" => $emp_stat,
            "user_account" => $user_account,

            // from job_posting_tb
            "job_id" => $job_id,
            "cover_photo" => $cover_photo,
            "job_title" => $job_title,
            "status" => $status,
            "field_industry" => $field_industry,
            "job_level" => $job_level,
            "yrs_of_experience_needed" => $yrs_of_experience_needed,
            "contractual_status" => $contractual_status,
            "salary" => $salary,
            "job_location" => $job_location,
            "job_description" => $job_description,
            "requirements" => $requirements,
            "job_responsibilities" => $job_responsibilities,
            "industry_partner" => $industry_partner
        );

        array_push($job_applications_arr["records"], $job_application_item);
    }

    http_response_code(200);
    echo json_encode($job_applications_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No job application found. Solve tihis on 'job_application/read.php'.\n"));
}