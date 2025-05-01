<?php
class EmpPartnerAccount
{
    private $conn;
    private $table_name = "industry_partner_tb";

    // Employer Partner Properties
    public $partner_id;
    public $profile_pic;
    public $partner_name;
    public $partner_location;
    public $contact_no;
    public $email_add;
    public $user_account;

    // Employer Partner Account Properties
    public $account_id;
    public $username;
    public $password;

    public function __construct($db)
    {
        $this->conn = $db;
    }

    // CRUD Operations
    /**
     * Create a new account
     *
     * @return boolean true if the account was created, false otherwise
     */
    function create()
    {
        $query = "INSERT INTO
                    " . $this->table_name . "
                SET
                    partner_id=:partner_id,
                    profile_pic=:profile_pic,
                    partner_name=:partner_name,
                    partner_location=:partner_location,
                    contact_no=:contact_no,
                    email_add=:email_add,
                    user_account=:user_account";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->partner_id = htmlspecialchars(strip_tags($this->partner_id));
        $this->profile_pic = htmlspecialchars(strip_tags($this->profile_pic));
        $this->partner_name = htmlspecialchars(strip_tags($this->partner_name));
        $this->partner_location = htmlspecialchars(strip_tags($this->partner_location));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->email_add = htmlspecialchars(strip_tags($this->email_add));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        // bind values
        $stmt->bindParam(":partner_id", $this->partner_id);
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);
        $stmt->bindParam(":user_account", $this->user_account);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Read all accounts
     *
     * @return PDOStatement
     */
    function read()
    {
        $query = "SELECT
                      ep.partner_id,
                      ep.profile_pic,
                      ep.partner_name,
                      ep.partner_location,
                      ep.contact_no,
                      ep.email_add,
                      ep.user_account,

                      ac.account_id,
                      ac.username,
                      ac.password
                    FROM " . $this->table_name . " ep
                    JOIN acc_employer_partner_tb ac 
                    ON ep.user_account = ac.account_id;";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    /**
     * Update a account
     *
     * @return boolean true if the account was updated, false otherwise
     */
    function update()
    {
        $query = "UPDATE " . $this->table_name . " ep
                    JOIN acc_employer_partner ac ON ep.user_account = ac.account_id
                  SET
                        ep.partner_id=:partner_id,
                        ep.profile_pic=:profile_pic,
                        ep.partner_name=:partner_name,
                        ep.partner_location=:partner_location,
                        ep.contact_no=:contact_no,
                        ep.email_add=:email_add,
                        ep.user_account=:user_account
                      
                        ac.account_id=:account_id,
                        ac.username=:username,
                        ac.password=:password
                  WHERE ep.partner_id = :partner_id";

        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->partner_id = htmlspecialchars(strip_tags($this->partner_id));
        $this->profile_pic = htmlspecialchars(strip_tags($this->profile_pic));
        $this->partner_name = htmlspecialchars(strip_tags($this->partner_name));
        $this->partner_location = htmlspecialchars(strip_tags($this->partner_location));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->email_add = htmlspecialchars(strip_tags($this->email_add));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        $this->account_id = htmlspecialchars(strip_tags($this->account_id));
        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->password = htmlspecialchars(strip_tags($this->password));

        // bind values
        $stmt->bindParam(":partner_id", $this->partner_id);
        $stmt->bindParam(":profile_pic", $this->profile_pic);
        $stmt->bindParam(":partner_name", $this->partner_name);
        $stmt->bindParam(":partner_location", $this->partner_location);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":email_add", $this->email_add);
        $stmt->bindParam(":user_account", $this->user_account);

        $stmt->bindParam(":account_id", $this->account_id);
        $stmt->bindParam(":username", $this->username);
        $stmt->bindParam(":password", $this->password);

        // execute the query
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Delete a account given its id
     *
     * @return boolean true if the account was deleted, false otherwise
     */
    function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE partner_id = :partner_id";

        $stmt = $this->conn->prepare($query);

        $this->partner_id = htmlspecialchars(strip_tags($this->partner_id));

        $stmt->bindParam(":partner_id", $this->partner_id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
