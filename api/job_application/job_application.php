<?php

class JobApplication
{
    private $conn;
    private $table_name = "job_application_tb";

    public $application_id;
    public $applicant;
    public $job;
    public $resume;
    public $cover_letter;
    public $skills;
    public $certifications;
    public $application_status;
    public $date_applied;

    // applicant_id refereces graduates_tb fields where the applicant_id is the student_no
    public $graduate_id;
    public $email;
    public $first_name;
    public $middle_name;
    public $last_name;
    public $course;
    public $department;
    public $bday;
    public $gender;
    public $age;
    public $address;
    public $contact_no;
    public $date_grad;
    public $emp_stat;
    public $user_account;

    // job references job_posting_tb fields where the job is the job_id
    public $job_id;
    public $cover_photo;
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

    // Constructor with $db as database connection
    public function __construct($db)
    {
        $this->conn = $db;
    }

    public function create()
    {
        // $query = "INSERT INTO
        //             " . $this->table_name . "
        //         SET
        //             applicant=:applicant,
        //             job=:job,
        //             resume=:resume,
        //             cover_letter=:cover_letter,
        //             skills=:skills,
        //             certifications=:certifications,
        //             application_status=:application_status
        //             date_applied=:date_applied";

        $query = "INSERT INTO " . $this->table_name . " (applicant, job, resume, cover_letter, skills, certifications, application_status, date_applied) 
                  VALUES (:applicant, :job, :resume, :cover_letter, :skills, :certifications, :application_status, :date_applied)";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->applicant = htmlspecialchars(strip_tags($this->applicant));
        $this->job = htmlspecialchars(strip_tags($this->job));
        $this->resume = htmlspecialchars(strip_tags($this->resume));
        $this->cover_letter = htmlspecialchars(strip_tags($this->cover_letter));
        $this->skills = htmlspecialchars(strip_tags($this->skills));
        $this->certifications = htmlspecialchars(strip_tags($this->certifications));
        $this->application_status = htmlspecialchars(strip_tags($this->application_status));
        $this->date_applied = htmlspecialchars(strip_tags($this->date_applied));

        // Bind parameters
        $stmt->bindParam(":applicant", $this->applicant);
        $stmt->bindParam(":job", $this->job);
        $stmt->bindParam(":resume", $this->resume);
        $stmt->bindParam(":cover_letter", $this->cover_letter);
        $stmt->bindParam(":skills", $this->skills);
        $stmt->bindParam(":certifications", $this->certifications);
        $stmt->bindParam(":application_status", $this->application_status);
        $stmt->bindParam(":date_applied", $this->date_applied);

        // Execute query    
        if ($stmt->execute()) {
            return true;
        }
    }

    public function read()
    {
        $query = "SELECT
                      ja.*,
                      gr.*,
                      jp.*
                  FROM " . $this->table_name . " ja
                  JOIN graduates_tb gr ON ja.applicant = gr.graduate_id
                  JOIN job_posting_tb jp ON ja.job = jp.job_id";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function update()
    {
        // $query = "UPDATE " . $this->table_name . " SET
        //     profile_pic = :profile_pic,
        //     partner_name = :partner_name,
        //     partner_location = :partner_location,
        //     contact_no = :contact_no,
        //     email_add = :email_add";

        // $stmt = $this->conn->prepare($query);

        // // Bind parameters
        // $stmt->bindParam(":profile_pic", $this->profile_pic);
        // $stmt->bindParam(":partner_name", $this->partner_name);
        // $stmt->bindParam(":partner_location", $this->partner_location);
        // $stmt->bindParam(":contact_no", $this->contact_no);
        // $stmt->bindParam(":email_add", $this->email_add);

        // return $stmt->execute();
    }

    public function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE application_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->application_id);
        return $stmt->execute();
    }
}
