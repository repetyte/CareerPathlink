<?php
class GraduatesLists
{
    private $conn;
    private $table_name = "graduates_lists";

    // Graduate Properties
    public $student_no;
    public $last_name;
    public $first_name;
    public $middle_name;
    public $birthdate;
    public $age;
    public $home_address;
    public $unc_email;
    public $personal_email;
    public $facebook_name;
    public $graduation_date;
    public $course;
    public $department;
    public $first_target_employer;
    public $second_target_employer;
    public $third_target_employer;


    public function __construct($db)
    {
        $this->conn = $db;
    }

    // CRUD Operations
    /**
     * Create a new job posting
     *
     * @return boolean true if the job posting was created, false otherwise
     */
    function create()
    {
        $query = "INSERT INTO
            " . $this->table_name . "
        SET
            student_no = :student_no,
            last_name = :last_name,
            first_name = :first_name,
            middle_name = :middle_name,
            birthdate = :birthdate,
            age = :age,
            home_address = :home_address,
            unc_email = :unc_email,
            personal_email = :personal_email,
            facebook_name = :facebook_name,
            graduation_date = :graduation_date,
            course = :course,
            department = :department,
            first_target_employer = :first_target_employer,
            second_target_employer = :second_target_employer,
            third_target_employer = :third_target_employer";


        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->student_no = htmlspecialchars(strip_tags($this->student_no));
        $this->last_name = htmlspecialchars(strip_tags($this->last_name));
        $this->first_name = htmlspecialchars(strip_tags($this->first_name));
        $this->middle_name = htmlspecialchars(strip_tags($this->middle_name));
        $this->birthdate = htmlspecialchars(strip_tags($this->birthdate));
        $this->age = htmlspecialchars(strip_tags($this->age));
        $this->home_address = htmlspecialchars(strip_tags($this->home_address));
        $this->unc_email = htmlspecialchars(strip_tags($this->unc_email));
        $this->personal_email = htmlspecialchars(strip_tags($this->personal_email));
        $this->facebook_name = htmlspecialchars(strip_tags($this->facebook_name));
        $this->graduation_date = htmlspecialchars(strip_tags($this->graduation_date));
        $this->course = htmlspecialchars(strip_tags($this->course));
        $this->department = htmlspecialchars(strip_tags($this->department));
        $this->first_target_employer = htmlspecialchars(strip_tags($this->first_target_employer));
        $this->second_target_employer = htmlspecialchars(strip_tags($this->second_target_employer));
        $this->third_target_employer = htmlspecialchars(strip_tags($this->third_target_employer));

        // bind values
        $stmt->bindParam(":student_no", $this->student_no);
        $stmt->bindParam(":last_name", $this->last_name);
        $stmt->bindParam(":first_name", $this->first_name);
        $stmt->bindParam(":middle_name", $this->middle_name);
        $stmt->bindParam(":birthdate", $this->birthdate);
        $stmt->bindParam(":age", $this->age);
        $stmt->bindParam(":home_address", $this->home_address);
        $stmt->bindParam(":unc_email", $this->unc_email);
        $stmt->bindParam(":personal_email", $this->personal_email);
        $stmt->bindParam(":facebook_name", $this->facebook_name);
        $stmt->bindParam(":graduation_date", $this->graduation_date);
        $stmt->bindParam(":course", $this->course);
        $stmt->bindParam(":department", $this->department);
        $stmt->bindParam(":first_target_employer", $this->first_target_employer);
        $stmt->bindParam(":second_target_employer", $this->second_target_employer);
        $stmt->bindParam(":third_target_employer", $this->third_target_employer);

        // execute query
        if ($stmt->execute()) {
            return true;
        }

        // Log SQL errors for debugging
        error_log("SQL Error: " . implode(", ", $stmt->errorInfo()));

        return false;
    }

    /**
     * Read all job postings
     *
     * @return PDOStatement
     */
    function read()
    {
        $query = "SELECT * FROM graduates_lists;";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    /**
     * Update a job posting
     *
     * @return boolean true if the job posting was updated, false otherwise
     */
    function update()
    {
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
    function delete()
    {
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
