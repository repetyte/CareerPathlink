<?php
class JobPosting {
    private $conn;
    private $table_name = "job_posting_tb";

    public $job_id;
    public $job_title;
    public $status;
    public $field_industry;
    public $job_level;
    public $yrs_of_experience_needed;
    public $contractual_status;
    public $salary;
    public $job_location;
    public $job_description;
    public $requirements;
    public $job_responsibilities;
    public $industry_partner;

    public function __construct($db){
        $this->conn = $db;
    }

    function read(){
        $query = "SELECT * FROM " . $this->table_name . " ORDER BY job_id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Create, Update, Delete methods...
}
?>
