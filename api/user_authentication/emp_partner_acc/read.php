<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../database.php';
include_once 'emp_partner_acc.php';

$database = new Database();
$db = $database->getConnection();

$account = new EmpPartnerAccount($db);

$stmt = $account->read();
$num = $stmt->rowCount();

if($num > 0){
    $accounts_arr = array();
    $accounts_arr["records"] = array();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        extract($row);

        $account_item = array(
            "partner_id" => $partner_id,
            "profile_pic" => $profile_pic,
            "partner_name" => $partner_name,
            "partner_location" => $partner_location,
            "contact_no" => $contact_no,
            "email_add" => $email_add,
            "user_account" => $user_account,
            "account_id" => $account_id,
            "username" => $username,
            "password" => $password
        );

        array_push($accounts_arr["records"], $account_item);
    }

    http_response_code(200);
    echo json_encode($accounts_arr["records"]);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No accounts found."));
}