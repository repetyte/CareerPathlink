<?php

class IndustryPartner{
    private $conn;
    private $table_name = "industry_partner_tb";

    public $partner_id;
    public $partner_name;
    public $partner_location;
    public $contact_no;
    public $email_add;
    public $profile_pic;

    public function __construct($db){
        $this->conn = $db;
    }

    function read(){
        $query = "SELECT * FROM " . $this->table_name . " ORDER BY partner_id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
}