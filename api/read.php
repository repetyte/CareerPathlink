<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'database.php';
include_once 'job_posting.php';

$database = new Database();
$db = $database->getConnection();

$job = new JobPosting($db);

$stmt = $job->read();
$num = $stmt->rowCount();

if($num > 0){
    $jobs_arr = array();
    $jobs_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $job_item = array(
            "job_id" => $job_id,
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
            "industry_partner" => $industry_partner,
        );

        array_push($jobs_arr["records"], $job_item);
    }

    http_response_code(200);
    echo json_encode($jobs_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No jobs found."));
}
?>
