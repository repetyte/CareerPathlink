<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '..\database.php';
include_once 'industry_partner.php';

$database = new Database();
$db = $database->getConnection();

$industry_partner = new IndustryPartner($db);

$stmt = $industry_partner->read();
$num = $stmt->rowCount();

if($num > 0){
    $industry_partners_arr = array();
    $industry_partners_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $industry_partner_item = array(
            "partner_id" => $partner_id,
            "profile_pic" => $profile_pic,
            "partner_name" => $partner_name,
            "partner_location" => $partner_location,
            "contact_no" => $contact_no,
            "email_add" => $email_add,
        );

        array_push($industry_partners_arr["records"], $industry_partner_item);
    }

    http_response_code(200);
    echo json_encode($industry_partners_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No industry partner found. Solve tihis on 'industry_partner/read.php'.\n"));
}