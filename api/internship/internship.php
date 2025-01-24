<?php
class InternshipWithPartner
{
    private $conn;
    private $table_name = "internship_tb";

    // Internship details
    public $internship_id;
    public $display_photo;
    public $internship_title;
    public $takehome_pay;
    public $location;
    public $description;
    public $required_skills;
    public $qualifications;
    public $hours;
    public $industry_partner;

    // Partner details
    public $partner_id;
    public $profile_pic;
    public $partner_name;
    public $partner_location;
    public $contact_no;
    public $email_add;

    public function __construct($db)
    {
        $this->conn = $db;
    }

    function read()
    {
        $query = "SELECT
                      i.internship_id, 
                      i.display_photo, 
                      i.internship_title, 
                      i.takehome_pay,
                      i.location,
                      i.description, 
                      i.required_skills, 
                      i.qualifications, 
                      i.hours, 
                      i.industry_partner,

                      p.partner_id, 
                      p.profile_pic, 
                      p.partner_name, 
                      p.partner_location, 
                      p.contact_no, 
                      p.email_add
            FROM " . $this->table_name . " i
            LEFT JOIN industry_partner_tb p
            ON i.industry_partner = p.partner_id
            ORDER BY i.internship_id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    function create()
    {
        $query = "INSERT INTO " . $this->table_name . " SET 
            display_photo=:display_photo,
            internship_title=:internship_title,
            takehome_pay=:takehome_pay,
            location=:location,
            description=:description,
            required_skills=:required_skills,
            qualifications=:qualifications,
            hours=:hours,
            industry_partner=:industry_partner";

        // Prepare query 
        $stmt = $this->conn->prepare($query);

        // Clean data
        $this->display_photo = htmlspecialchars(strip_tags($this->display_photo));
        $this->internship_title = htmlspecialchars(strip_tags($this->internship_title));
        $this->takehome_pay = htmlspecialchars(strip_tags($this->takehome_pay));
        $this->location = htmlspecialchars(strip_tags($this->location));
        $this->description = htmlspecialchars(strip_tags($this->description));
        $this->required_skills = htmlspecialchars(strip_tags($this->required_skills));
        $this->qualifications = htmlspecialchars(strip_tags($this->qualifications));
        $this->hours = htmlspecialchars(strip_tags($this->hours));
        $this->industry_partner = htmlspecialchars(strip_tags($this->industry_partner));

        // Bind values
        $stmt->bindParam(":display_photo", $this->display_photo);
        $stmt->bindParam(":internship_title", $this->internship_title);
        $stmt->bindParam(":takehome_pay", $this->takehome_pay);
        $stmt->bindParam(":location", $this->location);
        $stmt->bindParam(":description", $this->description);
        $stmt->bindParam(":required_skills", $this->required_skills);
        $stmt->bindParam(":qualifications", $this->qualifications);
        $stmt->bindParam(":hours", $this->hours);
        $stmt->bindParam(":industry_partner", $this->industry_partner);

        // Execute query
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    function update()
    {
        $query = "UPDATE " . $this->table_name . " i
                  JOIN industry_partner_tb p ON i.industry_partner = p.partner_id
                  SET
                        i.display_photo = :display_photo,
                        i.internship_title = :internship_title,
                        i.takehome_pay = :takehome_pay,
                        i.location = :location,
                        i.description = :description,
                        i.required_skills = :required_skills,
                        i.qualifications = :qualifications,
                        i.hours = :hours,
                        i.industry_partner = :industry_partner

                        p.partner_id = :partner_id,
                        p.profile_pic = :profile_pic,
                        p.partner_name = :partner_name,
                        p.partner_location = :partner_location,
                        p.contact_no = :contact_no,
                        p.email_add = :email_add
                  WHERE i.job_id = :job_id";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Clean data
        $this->internship_id = htmlspecialchars(strip_tags($this->internship_id));
        $this->display_photo = htmlspecialchars(strip_tags($this->display_photo));
        $this->internship_title = htmlspecialchars(strip_tags($this->internship_title));
        $this->takehome_pay = htmlspecialchars(strip_tags($this->takehome_pay));
        $this->location = htmlspecialchars(strip_tags($this->location));
        $this->description = htmlspecialchars(strip_tags($this->description));
        $this->required_skills = htmlspecialchars(strip_tags($this->required_skills));
        $this->qualifications = htmlspecialchars(strip_tags($this->qualifications));
        $this->hours = htmlspecialchars(strip_tags($this->hours));
        $this->industry_partner = htmlspecialchars(strip_tags($this->industry_partner));
        $this->partner_id = htmlspecialchars(strip_tags($this->partner_id));
        $this->profile_pic = htmlspecialchars(strip_tags($this->profile_pic));
        $this->partner_name = htmlspecialchars(strip_tags($this->partner_name));
        $this->partner_location = htmlspecialchars(strip_tags($this->partner_location));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->email_add = htmlspecialchars(strip_tags($this->email_add));

        // Bind values
        $stmt->bindParam(":internship_id", $this->internship_id);
        $stmt->bindParam(":display_photo", $this->display_photo);
        $stmt->bindParam(":internship_title", $this->internship_title);
        $stmt->bindParam(":takehome_pay", $this->takehome_pay);
        $stmt->bindParam(":location", $this->location);
        $stmt->bindParam(":description", $this->description);
        $stmt->bindParam(":required_skills", $this->required_skills);
        $stmt->bindParam(":qualifications", $this->qualifications);
        $stmt->bindParam(":hours", $this->hours);
        $stmt->bindParam(":industry_partner", $this->industry_partner);
        $stmt->bindParam(":partner_id", $this->partner_id);
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);

        // Execute query
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE internship_id = ?";
        $stmt = $this->conn->prepare($query);
        $this->internship_id = htmlspecialchars(strip_tags($this->internship_id));
        $stmt->bindParam(1, $this->internship_id);
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
}
