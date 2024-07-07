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
    public $cover_photo;
    public $partner_id;
    public $profile_pic;
    public $partner_name;
    public $partner_location;
    public $contact_no;
    public $email_add;

    public function __construct($db){
        $this->conn = $db;
    }

    function read(){
//         $query = "SELECT * FROM " . $this->table_name . " ORDER BY job_id DESC";
        $query = "SELECT
                      jp.job_id,
                      jp.job_title,
                      jp.status,
                      jp.field_industry,
                      jp.job_level,
                      jp.yrs_of_experience_needed,
                      jp.contractual_status,
                      jp.salary,
                      jp.job_location,
                      jp.job_description,
                      jp.requirements,
                      jp.job_responsibilities,
                      jp.cover_photo,
                      ip.partner_id,
                      ip.profile_pic,
                      ip.partner_name,
                      ip.partner_location,
                      ip.contact_no,
                      ip.email_add
                  FROM job_posting_tb jp
                  JOIN industry_partner_tb ip ON jp.industry_partner = ip.partner_id;";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    function create() {
        $query = "INSERT INTO
                    " . $this->table_name . "
                SET
                    job_title=:job_title,
                    status=:status,
                    field_industry=:field_industry,
                    job_level=:job_level,
                    yrs_of_experience_needed=:yrs_of_experience_needed,
                    contractual_status=:contractual_status,
                    salary=:salary,
                    job_location=:job_location,
                    job_description=:job_description,
                    requirements=:requirements,
                    job_responsibilities=:job_responsibilities,
                    cover_photo=:cover_photo,
                    profile_pic=:profile_pic,
                    partner_name=:partner_name,
                    partner_location=:partner_location,
                    contact_no=:contact_no,
                    email_add=:email_add";
    
        $stmt = $this->conn->prepare($query);
    
        $this->job_title = htmlspecialchars(strip_tags($this->job_title));
        $this->status = htmlspecialchars(strip_tags($this->status));
        $this->field_industry = htmlspecialchars(strip_tags($this->field_industry));
        $this->job_level = htmlspecialchars(strip_tags($this->job_level));
        $this->yrs_of_experience_needed = htmlspecialchars(strip_tags($this->yrs_of_experience_needed));
        $this->contractual_status = htmlspecialchars(strip_tags($this->contractual_status));
        $this->salary = htmlspecialchars(strip_tags($this->salary));
        $this->job_location = htmlspecialchars(strip_tags($this->job_location));
        $this->job_description = htmlspecialchars(strip_tags($this->job_description));
        $this->requirements = htmlspecialchars(strip_tags($this->requirements));
        $this->job_responsibilities = htmlspecialchars(strip_tags($this->job_responsibilities));
        $this->cover_photo = htmlspecialchars(strip_tags($this->cover_photo));
        $this->profile_pic = htmlspecialchars(strip_tags($this->profile_pic));
        $this->partner_name = htmlspecialchars(strip_tags($this->partner_name));
        $this->partner_location = htmlspecialchars(strip_tags($this->partner_location));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->email_add = htmlspecialchars(strip_tags($this->email_add));
    
        $stmt->bindParam(":job_title", $this->job_title);
        $stmt->bindParam(":status", $this->status);
        $stmt->bindParam(":field_industry", $this->field_industry);
        $stmt->bindParam(":job_level", $this->job_level);
        $stmt->bindParam(":yrs_of_experience_needed", $this->yrs_of_experience_needed);
        $stmt->bindParam(":contractual_status", $this->contractual_status);
        $stmt->bindParam(":salary", $this->salary);
        $stmt->bindParam(":job_location", $this->job_location);
        $stmt->bindParam(":job_description", $this->job_description);
        $stmt->bindParam(":requirements", $this->requirements);
        $stmt->bindParam(":job_responsibilities", $this->job_responsibilities);
        $stmt->bindParam(":cover_photo", $this->cover_photo);
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);
    
        if ($stmt->execute()) {
            return true;
        }
    
        return false;
    }

    function update(){
        $query = "UPDATE " . $this->table_name . "
                  SET
                      job_title=:job_title,
                      status=:status,
                      field_industry=:field_industry,
                      job_level=:job_level,
                      yrs_of_experience_needed=:yrs_of_experience_needed,
                      contractual_status=:contractual_status,
                      salary=:salary,
                      job_location=:job_location,
                      job_description=:job_description,
                      requirements=:requirements,
                      job_responsibilities=:job_responsibilities,
                      industry_partner=:industry_partner
                  WHERE job_id = :job_id";

        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->job_id=htmlspecialchars(strip_tags($this->job_id));
        $this->job_title=htmlspecialchars(strip_tags($this->job_title));
        $this->status=htmlspecialchars(strip_tags($this->status));
        $this->field_industry=htmlspecialchars(strip_tags($this->field_industry));
        $this->job_level=htmlspecialchars(strip_tags($this->job_level));
        $this->yrs_of_experience_needed=htmlspecialchars(strip_tags($this->yrs_of_experience_needed));
        $this->contractual_status=htmlspecialchars(strip_tags($this->contractual_status));
        $this->salary=htmlspecialchars(strip_tags($this->salary));
        $this->job_location=htmlspecialchars(strip_tags($this->job_location));
        $this->job_description=htmlspecialchars(strip_tags($this->job_description));
        $this->requirements=htmlspecialchars(strip_tags($this->requirements));
        $this->job_responsibilities=htmlspecialchars(strip_tags($this->job_responsibilities));
        $this->industry_partner=htmlspecialchars(strip_tags($this->industry_partner));

        // Bind parameters
        $stmt->bindParam(':job_id', $this->job_id);
        $stmt->bindParam(':job_title', $this->job_title);
        $stmt->bindParam(':status', $this->status);
        $stmt->bindParam(':field_industry', $this->field_industry);
        $stmt->bindParam(':job_level', $this->job_level);
        $stmt->bindParam(':yrs_of_experience_needed', $this->yrs_of_experience_needed);
        $stmt->bindParam(':contractual_status', $this->contractual_status);
        $stmt->bindParam(':salary', $this->salary);
        $stmt->bindParam(':job_location', $this->job_location);
        $stmt->bindParam(':job_description', $this->job_description);
        $stmt->bindParam(':requirements', $this->requirements);
        $stmt->bindParam(':job_responsibilities', $this->job_responsibilities);
        $stmt->bindParam(':industry_partner', $this->industry_partner);

        if($stmt->execute()){
            return true;
        }

        return false;
    }
    function delete(){
        $query = "DELETE FROM " . $this->table_name . " WHERE job_id = :job_id";
        $stmt = $this->conn->prepare($query);
        $this->job_id=htmlspecialchars(strip_tags($this->job_id));
        $stmt->bindParam(':job_id', $this->job_id); // Correct binding
        if($stmt->execute()){
            return true;
        }

        return false;
    }

}
