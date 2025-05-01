<?php
class CCDAccount
{
    private $conn;
    private $table_name = "career_center_director_tb";

    // Career Center Director Properties
    public $director_id;
    public $unc_email;
    public $first_name;
    public $middle_name;
    public $last_name;
    public $user_account;

    // User Account Properties
    public $account_id;
    public $username;
    public $password;

    public function __construct($db)
    {
        $this->conn = $db;
    }

    // CRUD Operations
    /**
     * Create a new career center director account
     *
     * @return boolean true if the account posting was created, false otherwise
     */
    function create()
    {
        $query = "INSERT INTO
                    " . $this->table_name . "
                SET
                    director_id=:director_id,
                    unc_email=:unc_email,
                    first_name=:first_name,
                    middle_name=:middle_name,
                    last_name=:last_name,
                    user_account=:user_account";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->director_id = htmlspecialchars(strip_tags($this->director_id));
        $this->unc_email = htmlspecialchars(strip_tags($this->unc_email));
        $this->first_name = htmlspecialchars(strip_tags($this->first_name));
        $this->middle_name = htmlspecialchars(strip_tags($this->middle_name));
        $this->last_name = htmlspecialchars(strip_tags($this->last_name));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        // bind values
        $stmt->bindParam(":director_id", $this->director_id);
        $stmt->bindParam(":unc_email", $this->unc_email);
        $stmt->bindParam(":first_name", $this->first_name);
        $stmt->bindParam(":middle_name", $this->middle_name);
        $stmt->bindParam(":last_name", $this->last_name);
        $stmt->bindParam(":user_account", $this->user_account);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Read all career center director accounts
     *
     * @return PDOStatement
     */
    function read()
    {
        $query = "SELECT
                      jp.director_id,
                      jp.unc_email,
                      jp.first_name,
                      jp.middle_name,
                      jp.last_name,
                      jp.user_account,
                      
                      ip.account_id,
                      ip.username,
                      ip.password
                  FROM " . $this->table_name . " jp
                  JOIN acc_career_center_director_tb ip 
                  ON jp.user_account = ip.account_id";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // To be revised..
    function update()
    {
        $query = "UPDATE
                    " . $this->table_name . "
                SET
                    unc_email=:unc_email,
                    first_name=:first_name,
                    middle_name=:middle_name,
                    last_name=:last_name,
                    user_account=:user_account
                WHERE
                    director_id=:director_id";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->director_id = htmlspecialchars(strip_tags($this->director_id));
        $this->unc_email = htmlspecialchars(strip_tags($this->unc_email));
        $this->first_name = htmlspecialchars(strip_tags($this->first_name));
        $this->middle_name = htmlspecialchars(strip_tags($this->middle_name));
        $this->last_name = htmlspecialchars(strip_tags($this->last_name));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        // bind values
        $stmt->bindParam(":director_id", $this->director_id);
        $stmt->bindParam(":unc_email", $this->unc_email);
        $stmt->bindParam(":first_name", $this->first_name);
        $stmt->bindParam(":middle_name", $this->middle_name);
        $stmt->bindParam(":last_name", $this->last_name);
        $stmt->bindParam(":user_account", $this->user_account);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Delete a career center director account by account_id
     *
     * @return boolean true if the account posting was deleted, false otherwise
     */
    function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE director_id = :director_id";
        $stmt = $this->conn->prepare($query);

        $this->director_id = htmlspecialchars(strip_tags($this->director_id));
        $stmt->bindParam(':director_id', $this->director_id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
