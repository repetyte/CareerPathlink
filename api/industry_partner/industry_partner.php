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

    /**
     * Inserts a new industry partner record into the database.
     *
     * Binds the current object's properties to the SQL query parameters
     * and executes the statement to insert the new record.
     *
     * @return bool True if the record was successfully inserted, false otherwise.
     */
    public function create() {
        $query = "INSERT INTO " . $this->table_name . " SET
            profile_pic = :profile_pic,
            partner_name = :partner_name,
            partner_location = :partner_location,
            contact_no = :contact_no,
            email_add = :email_add";

        // Prepare query
        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->profile_pic=htmlspecialchars(strip_tags($this->profile_pic));
        $this->partner_name=htmlspecialchars(strip_tags($this->partner_name));
        $this->partner_location=htmlspecialchars(strip_tags($this->partner_location));
        $this->contact_no=htmlspecialchars(strip_tags($this->contact_no));
        $this->email_add=htmlspecialchars(strip_tags($this->email_add));

        // Validate input
        if (empty($this->profile_pic) || empty($this->partner_name) || empty($this->partner_location) || empty($this->contact_no) || empty($this->email_add)) {
            return false;
        }

        // Bind parameters
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);

        // Execute query    
        if ($stmt->execute()) {
            return true;
        }
    }

    /**
     * Retrieves all industry partner records from the database.
     *
     * @return PDOStatement Statement with all industry partner records
     */
    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    /**
     * Updates an existing industry partner record in the database.
     *
     * Binds the current object's properties to the SQL query parameters
     * and executes the statement to update the existing record based on
     * the partner's identifier.
     *
     * @return bool True if the record was successfully updated, false otherwise.
     */
    public function update() {
        $query = "UPDATE " . $this->table_name . " SET
            profile_pic = :profile_pic,
            partner_name = :partner_name,
            partner_location = :partner_location,
            contact_no = :contact_no,
            email_add = :email_add";

        $stmt = $this->conn->prepare($query);

        // Bind parameters
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);

        return $stmt->execute();
    }

    /**
     * Deletes an existing industry partner record from the database.
     *
     * Binds the current object's partner_id property to the SQL query parameter
     * and executes the statement to delete the existing record based on
     * the partner's identifier.
     *
     * @return bool True if the record was successfully deleted, false otherwise.
     */
    public function delete() {
        $query = "DELETE FROM " . $this->table_name . " WHERE partner_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->partner_id);
        return $stmt->execute();
    }
}