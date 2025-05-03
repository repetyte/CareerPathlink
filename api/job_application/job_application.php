<?php

class JobApplication
{
    private $conn;
    private $table_name = "job_application_tb";

    public $application_id;
    public $job;
    public $applicant_first_name;
    public $applicant_last_name;
    public $degree;
    public $applicant_location;
    public $applicant_contact_no;
    public $applicant_email;
    public $resume;
    public $cover_letter;
    public $skills;
    public $certifications;
    public $application_status;
    public $date_applied;

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
        $query = "INSERT INTO " . $this->table_name . " (job, applicant_first_name, applicant_last_name, degree, applicant_location, applicant_contact_no, applicant_email, resume, cover_letter, skills, certifications, application_status, date_applied) 
              VALUES (:job, :applicant_first_name, :applicant_last_name, :degree, :applicant_location, :applicant_contact_no, :applicant_email, :resume, :cover_letter, :skills, :certifications, :application_status, :date_applied)";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->job = htmlspecialchars(strip_tags($this->job));
        $this->applicant_first_name = htmlspecialchars(strip_tags($this->applicant_first_name));
        $this->applicant_last_name = htmlspecialchars(strip_tags($this->applicant_last_name));
        $this->degree = htmlspecialchars(strip_tags($this->degree));
        $this->applicant_location = htmlspecialchars(strip_tags($this->applicant_location));
        $this->applicant_contact_no = htmlspecialchars(strip_tags($this->applicant_contact_no));
        $this->applicant_email = htmlspecialchars(strip_tags($this->applicant_email));
        $this->resume = htmlspecialchars(strip_tags($this->resume));
        $this->cover_letter = htmlspecialchars(strip_tags($this->cover_letter));
        $this->skills = htmlspecialchars(strip_tags($this->skills));
        $this->certifications = htmlspecialchars(strip_tags($this->certifications));
        $this->application_status = htmlspecialchars(strip_tags($this->application_status));
        $this->date_applied = htmlspecialchars(strip_tags($this->date_applied));

        // Bind parameters
        $stmt->bindParam(":job", $this->job);
        $stmt->bindParam(":applicant_first_name", $this->applicant_first_name);
        $stmt->bindParam(":applicant_last_name", $this->applicant_last_name);
        $stmt->bindParam(":degree", $this->degree);
        $stmt->bindParam(":applicant_location", $this->applicant_location);
        $stmt->bindParam(":applicant_contact_no", $this->applicant_contact_no);
        $stmt->bindParam(":applicant_email", $this->applicant_email);
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
        return false;
    }

    public function read()
    {
        $query = "SELECT
                      ja.*,
                      jp.*
                  FROM " . $this->table_name . " ja
                  JOIN job_posting_tb jp ON ja.job = jp.job_id;";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function update()
    {
        $query = "UPDATE " . $this->table_name . " 
        SET
            job = :job,
            applicant_first_name = :applicant_first_name,
            applicant_last_name = :applicant_last_name,
            degree = :degree,
            applicant_location = :applicant_location,
            applicant_contact_no = :applicant_contact_no,
            applicant_email = :applicant_email,
            resume = :resume,
            cover_letter = :cover_letter,
            skills = :skills,
            certifications = :certifications,
            application_status = :application_status,
            date_applied = :date_applied
        WHERE application_id = :application_id";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->application_id = htmlspecialchars(strip_tags($this->application_id));
        $this->job = htmlspecialchars(strip_tags($this->job));
        $this->applicant_first_name = htmlspecialchars(strip_tags($this->applicant_first_name));
        $this->applicant_last_name = htmlspecialchars(strip_tags($this->applicant_last_name));
        $this->degree = htmlspecialchars(strip_tags($this->degree));
        $this->applicant_location = htmlspecialchars(strip_tags($this->applicant_location));
        $this->applicant_contact_no = htmlspecialchars(strip_tags($this->applicant_contact_no));
        $this->applicant_email = htmlspecialchars(strip_tags($this->applicant_email));
        $this->resume = htmlspecialchars(strip_tags($this->resume));
        $this->cover_letter = htmlspecialchars(strip_tags($this->cover_letter));
        $this->skills = htmlspecialchars(strip_tags($this->skills));
        $this->certifications = htmlspecialchars(strip_tags($this->certifications));
        $this->application_status = htmlspecialchars(strip_tags($this->application_status));
        $this->date_applied = htmlspecialchars(strip_tags($this->date_applied));

        // Bind parameters
        $stmt->bindParam(":application_id", $this->application_id);
        $stmt->bindParam(":job", $this->job);
        $stmt->bindParam(":applicant_first_name", $this->applicant_first_name);
        $stmt->bindParam(":applicant_last_name", $this->applicant_last_name);
        $stmt->bindParam(":degree", $this->degree);
        $stmt->bindParam(":applicant_location", $this->applicant_location);
        $stmt->bindParam(":applicant_contact_no", $this->applicant_contact_no);
        $stmt->bindParam(":applicant_email", $this->applicant_email);
        $stmt->bindParam(":resume", $this->resume);
        $stmt->bindParam(":cover_letter", $this->cover_letter);
        $stmt->bindParam(":skills", $this->skills);
        $stmt->bindParam(":certifications", $this->certifications);
        $stmt->bindParam(":application_status", $this->application_status);
        $stmt->bindParam(":date_applied", $this->date_applied);
        
        // Execute query
        return $stmt->execute();
    }

    public function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE application_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->application_id);
        return $stmt->execute();
    }
}
