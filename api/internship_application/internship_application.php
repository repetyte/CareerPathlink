<?php

class InternshipApplication
{
    private $conn;
    private $table_name = "internship_application_tb";

    public $application_id;
    public $applicant;
    public $internship;
    public $resume;
    public $cover_letter;
    public $skills;
    public $certifications;
    public $application_status;
    public $date_applied;

    // applicant_id refereces student_tb fields where the applicant_id is the student_id
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

    // internship references internship_tb fields where the internship is the internship_id
    public $internship_id;
    public $display_photo;
    public $internship_title;
    public $hours;
    public $takehome_pay;
    public $location;
    public $description;
    public $required_skills;
    public $qualifications;
    public $industry_partner;

    // Constructor with $db as database connection
    public function __construct($db)
    {
        $this->conn = $db;
    }

    public function create()
    {
        $query = "INSERT INTO " . $this->table_name . " (applicant, internship, resume, cover_letter, skills, certifications, application_status, date_applied) 
                  VALUES (:applicant, :internship, :resume, :cover_letter, :skills, :certifications, :application_status, :date_applied)";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->applicant = htmlspecialchars(strip_tags($this->applicant));
        $this->internship = htmlspecialchars(strip_tags($this->internship));
        $this->resume = htmlspecialchars(strip_tags($this->resume));
        $this->cover_letter = htmlspecialchars(strip_tags($this->cover_letter));
        $this->skills = htmlspecialchars(strip_tags($this->skills));
        $this->certifications = htmlspecialchars(strip_tags($this->certifications));
        $this->application_status = htmlspecialchars(strip_tags($this->application_status));
        $this->date_applied = htmlspecialchars(strip_tags($this->date_applied));

        // Bind parameters
        $stmt->bindParam(":applicant", $this->applicant);
        $stmt->bindParam(":internship", $this->internship);
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
                      ia.*,
                      st.*,
                      ip.*
                  FROM " . $this->table_name . " ia
                  JOIN student_tb st ON ia.applicant = st.student_id
                  JOIN internship_tb ip ON ia.internship = ip.internship_id";
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
