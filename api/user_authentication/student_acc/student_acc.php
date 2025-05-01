<?php
class StudentAccount {
    private $conn;
    private $table_name = "student_tb";

    // Job Posting Properties
    public $student_id;
    public $first_name;
    public $middle_name;
    public $last_name;
    public $email;
    public $course;
    public $department;
    public $contact_no;
    public $bday;
    public $gender;
    public $age;
    public $address;
    public $user_account;

    // Industry Partner Properties
    public $account_id;
    public $username;
    public $password;


    public function __construct($db){
        $this->conn = $db;
    }

    // CRUD Operations
    /**
     * Create a new job posting
     *
     * @return boolean true if the job posting was created, false otherwise
     */
    function create() {
        // $query = "INSERT INTO
        //             " . $this->table_name . "
        //         SET
        //             cover_photo=:cover_photo,    
        //             job_title=:job_title,
        //             status=:status,
        //             field_industry=:field_industry,
        //             job_level=:job_level,
        //             yrs_of_experience_needed=:yrs_of_experience_needed,
        //             contractual_status=:contractual_status,
        //             salary=:salary,
        //             job_location=:job_location,
        //             job_description=:job_description,
        //             requirements=:requirements,
        //             job_responsibilities=:job_responsibilities,
        //             industry_partner=:industry_partner";
    
        // // prepare query
        // $stmt = $this->conn->prepare($query);
    
        // // sanitize input
        // $this->cover_photo = htmlspecialchars(strip_tags($this->cover_photo));
        // $this->job_title = htmlspecialchars(strip_tags($this->job_title));
        // $this->status = htmlspecialchars(strip_tags($this->status));
        // $this->field_industry = htmlspecialchars(strip_tags($this->field_industry));
        // $this->job_level = htmlspecialchars(strip_tags($this->job_level));
        // $this->yrs_of_experience_needed = htmlspecialchars(strip_tags($this->yrs_of_experience_needed));
        // $this->contractual_status = htmlspecialchars(strip_tags($this->contractual_status));
        // $this->salary = htmlspecialchars(strip_tags($this->salary));
        // $this->job_location = htmlspecialchars(strip_tags($this->job_location));
        // $this->job_description = htmlspecialchars(strip_tags($this->job_description));
        // $this->requirements = htmlspecialchars(strip_tags($this->requirements));
        // $this->job_responsibilities = htmlspecialchars(strip_tags($this->job_responsibilities));
        // $this->industry_partner = htmlspecialchars(strip_tags($this->industry_partner));
    
        // // bind values
        // $stmt->bindParam(":cover_photo", $this->cover_photo);
        // $stmt->bindParam(":job_title", $this->job_title);
        // $stmt->bindParam(":status", $this->status);
        // $stmt->bindParam(":field_industry", $this->field_industry);
        // $stmt->bindParam(":job_level", $this->job_level);
        // $stmt->bindParam(":yrs_of_experience_needed", $this->yrs_of_experience_needed);
        // $stmt->bindParam(":contractual_status", $this->contractual_status);
        // $stmt->bindParam(":salary", $this->salary);
        // $stmt->bindParam(":job_location", $this->job_location);
        // $stmt->bindParam(":job_description", $this->job_description);
        // $stmt->bindParam(":requirements", $this->requirements);
        // $stmt->bindParam(":job_responsibilities", $this->job_responsibilities);
        // $stmt->bindParam(":industry_partner", $this->industry_partner);
    
        // // execute query
        // if ($stmt->execute()) {
        //     return true;
        // }
    
        // return false;
    }

    /**
     * Read all job postings
     *
     * @return PDOStatement
     */
    function read(){
        $query = "SELECT
                      jp.student_id,
                      jp.first_name,
                      jp.middle_name,
                      jp.last_name,
                      jp.email,
                      jp.course,
                      jp.department,
                      jp.contact_no,
                      jp.bday,
                      jp.gender,
                      jp.age,
                      jp.address,
                      jp.user_account,
                      
                      ip.account_id,
                      ip.username,
                      ip.password,
                      ip.resume,
                      ip.skills,
                      ip.certifications
                  FROM " . $this->table_name . " jp
                  JOIN acc_student_tb ip ON jp.user_account = ip.account_id;";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    /**
     * Update a job posting
     *
     * @return boolean true if the job posting was updated, false otherwise
     */
    function update(){
        // $query = "UPDATE " . $this->table_name . " jp
        //           JOIN industry_partner_tb ip ON jp.industry_partner = ip.partner_id
        //           SET
        //               jp.job_title=:job_title,
        //               jp.cover_photo=:cover_photo,
        //               jp.status=:status,
        //               jp.field_industry=:field_industry,
        //               jp.job_level=:job_level,
        //               jp.yrs_of_experience_needed=:yrs_of_experience_needed,
        //               jp.contractual_status=:contractual_status,
        //               jp.salary=:salary,
        //               jp.job_location=:job_location,
        //               jp.job_description=:job_description,
        //               jp.requirements=:requirements,
        //               jp.job_responsibilities=:job_responsibilities,
        //               jp.industry_partner=:industry_partner,
                      
        //               ip.partner_name=:partner_name,
        //               ip.profile_pic=:profile_pic,
        //               ip.partner_location=:partner_location,
        //               ip.contact_no=:contact_no,
        //               ip.email_add=:email_add
        //           WHERE jp.job_id = :job_id";

        // $stmt = $this->conn->prepare($query);

        // // Sanitize input
        // $this->job_id=htmlspecialchars(strip_tags($this->job_id));
        // $this->cover_photo=htmlspecialchars(strip_tags($this->cover_photo));
        // $this->job_title=htmlspecialchars(strip_tags($this->job_title));
        // $this->status=htmlspecialchars(strip_tags($this->status));
        // $this->field_industry=htmlspecialchars(strip_tags($this->field_industry));
        // $this->job_level=htmlspecialchars(strip_tags($this->job_level));
        // $this->yrs_of_experience_needed=htmlspecialchars(strip_tags($this->yrs_of_experience_needed));
        // $this->contractual_status=htmlspecialchars(strip_tags($this->contractual_status));
        // $this->salary=htmlspecialchars(strip_tags($this->salary));
        // $this->job_location=htmlspecialchars(strip_tags($this->job_location));
        // $this->job_description=htmlspecialchars(strip_tags($this->job_description));
        // $this->requirements=htmlspecialchars(strip_tags($this->requirements));
        // $this->job_responsibilities=htmlspecialchars(strip_tags($this->job_responsibilities));
        // $this->industry_partner=htmlspecialchars(strip_tags($this->industry_partner));
        // $this->partner_name=htmlspecialchars(strip_tags($this->partner_name));
        // $this->profile_pic=htmlspecialchars(strip_tags($this->profile_pic));
        // $this->partner_location=htmlspecialchars(strip_tags($this->partner_location));
        // $this->contact_no=htmlspecialchars(strip_tags($this->contact_no));
        // $this->email_add=htmlspecialchars(strip_tags($this->email_add));

        // // Bind parameters
        // $stmt->bindParam(':job_id', $this->job_id);
        // $stmt->bindParam(':cover_photo', $this->cover_photo);
        // $stmt->bindParam(':job_title', $this->job_title);
        // $stmt->bindParam(':status', $this->status);
        // $stmt->bindParam(':field_industry', $this->field_industry);
        // $stmt->bindParam(':job_level', $this->job_level);
        // $stmt->bindParam(':yrs_of_experience_needed', $this->yrs_of_experience_needed);
        // $stmt->bindParam(':contractual_status', $this->contractual_status);
        // $stmt->bindParam(':salary', $this->salary);
        // $stmt->bindParam(':job_location', $this->job_location);
        // $stmt->bindParam(':job_description', $this->job_description);
        // $stmt->bindParam(':requirements', $this->requirements);
        // $stmt->bindParam(':job_responsibilities', $this->job_responsibilities);
        // $stmt->bindParam(':industry_partner', $this->industry_partner);
        // $stmt->bindParam(':partner_name', $this->partner_name);
        // $stmt->bindParam(':profile_pic', $this->profile_pic);
        // $stmt->bindParam(':partner_location', $this->partner_location);
        // $stmt->bindParam(':contact_no', $this->contact_no);
        // $stmt->bindParam(':email_add', $this->email_add);

        // if($stmt->execute()){
        //     return true;
        // }

        // return false;
    }

    /**
     * Delete a job posting given its id
     *
     * @return boolean true if the job posting was deleted, false otherwise
     */
    function delete(){
        // $query = "DELETE FROM " . $this->table_name . " WHERE job_id = :job_id";
        // $stmt = $this->conn->prepare($query);
        // $this->job_id=htmlspecialchars(strip_tags($this->job_id));
        // $stmt->bindParam(':job_id', $this->job_id); // Correct binding
        // if($stmt->execute()){
        //     return true;
        // }

        // return false;
    }

}
