<?php
class GraduateAccount
{
    private $conn;
    private $table_name = "graduates_tb";

    // Graduate Properties
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
     * Create a new job posting
     *
     * @return boolean true if the job posting was created, false otherwise
     */
    function create()
    {
        $query = "INSERT INTO
                    " . $this->table_name . "
                SET
                    graduate_id=:graduate_id,
                    email=:email,
                    first_name=:first_name,
                    middle_name=:middle_name,
                    last_name=:last_name,
                    course=:course,
                    department=:department,
                    bday=:bday,
                    gender=:gender,
                    age=:age,
                    address=:address,
                    contact_no=:contact_no,
                    date_grad=:date_grad,
                    emp_stat=:emp_stat,
                    user_account=:user_account";

        // prepare query
        $stmt = $this->conn->prepare($query);

        // sanitize input
        $this->graduate_id = htmlspecialchars(strip_tags($this->graduate_id));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->first_name = htmlspecialchars(strip_tags($this->first_name));
        $this->middle_name = htmlspecialchars(strip_tags($this->middle_name));
        $this->last_name = htmlspecialchars(strip_tags($this->last_name));
        $this->course = htmlspecialchars(strip_tags($this->course));
        $this->department = htmlspecialchars(strip_tags($this->department));
        $this->bday = htmlspecialchars(strip_tags($this->bday));
        $this->gender = htmlspecialchars(strip_tags($this->gender));
        $this->age = htmlspecialchars(strip_tags($this->age));
        $this->address = htmlspecialchars(strip_tags($this->address));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->date_grad = htmlspecialchars(strip_tags($this->date_grad));
        $this->emp_stat = htmlspecialchars(strip_tags($this->emp_stat));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        // bind values
        $stmt->bindParam(":graduate_id", $this->graduate_id);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":first_name", $this->first_name);
        $stmt->bindParam(":middle_name", $this->middle_name);
        $stmt->bindParam(":last_name", $this->last_name);
        $stmt->bindParam(":course", $this->course);
        $stmt->bindParam(":department", $this->department);
        $stmt->bindParam(":bday", $this->bday);
        $stmt->bindParam(":gender", $this->gender);
        $stmt->bindParam(":age", $this->age);
        $stmt->bindParam(":address", $this->address);
        $stmt->bindParam(":contact_no", $this->contact_no);
        $stmt->bindParam(":date_grad", $this->date_grad);
        $stmt->bindParam(":emp_stat", $this->emp_stat);
        $stmt->bindParam(":user_account", $this->user_account);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Read all job postings
     *
     * @return PDOStatement
     */
    function read()
    {
        $query = "SELECT
                      gd.graduate_id,
                        gd.email,
                        gd.first_name,
                        gd.middle_name,
                        gd.last_name,
                        gd.course,
                        gd.department,
                        gd.bday,
                        gd.gender,
                        gd.age,
                        gd.address,
                        gd.contact_no,
                        gd.date_grad,
                        gd.emp_stat,
                        gd.user_account,

                        ac.account_id,
                        ac.username,
                        ac.password
                    FROM " . $this->table_name . " gd
                    JOIN acc_graduates_tb ac
                    ON gd.user_account = ac.account_id;";
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
        $query = "UPDATE " . $this->table_name . " gd
                    JOIN acc_graduates_tb ac ON ip.user_account = ac.account_id
                  SET
                        gd.graduate_id=:graduate_id,
                        gd.email=:email,
                        gd.first_name=:first_name,
                        gd.middle_name=:middle_name,
                        gd.last_name=:last_name,
                        gd.course=:course,
                        gd.department=:department,
                        gd.bday=:bday,
                        gd.gender=:gender,
                        gd.age=:age,
                        gd.address=:address,
                        gd.contact_no=:contact_no,
                        gd.date_grad=:date_grad,
                        gd.emp_stat=:emp_stat,
                        gd.user_account=:user_account,

                        ac.account_id=:account_id,
                        ac.username=:username,
                        ac.password=:password

                    WHERE ip.partner_id = :partner_id";

        $stmt = $this->conn->prepare($query);

        // Sanitize input
        $this->graduate_id = htmlspecialchars(strip_tags($this->graduate_id));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->first_name = htmlspecialchars(strip_tags($this->first_name));
        $this->middle_name = htmlspecialchars(strip_tags($this->middle_name));
        $this->last_name = htmlspecialchars(strip_tags($this->last_name));
        $this->course = htmlspecialchars(strip_tags($this->course));
        $this->department = htmlspecialchars(strip_tags($this->department));
        $this->bday = htmlspecialchars(strip_tags($this->bday));
        $this->gender = htmlspecialchars(strip_tags($this->gender));
        $this->age = htmlspecialchars(strip_tags($this->age));
        $this->address = htmlspecialchars(strip_tags($this->address));
        $this->contact_no = htmlspecialchars(strip_tags($this->contact_no));
        $this->date_grad = htmlspecialchars(strip_tags($this->date_grad));
        $this->emp_stat = htmlspecialchars(strip_tags($this->emp_stat));
        $this->user_account = htmlspecialchars(strip_tags($this->user_account));

        $this->account_id = htmlspecialchars(strip_tags($this->account_id));
        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->password = htmlspecialchars(strip_tags($this->password));

        // Bind parameters
        $stmt->bindParam(':graduate_id', $this->graduate_id);
        $stmt->bindParam(':email', $this->email);
        $stmt->bindParam(':first_name', $this->first_name);
        $stmt->bindParam(':middle_name', $this->middle_name);
        $stmt->bindParam(':last_name', $this->last_name);
        $stmt->bindParam(':course', $this->course);
        $stmt->bindParam(':department', $this->department);
        $stmt->bindParam(':bday', $this->bday);
        $stmt->bindParam(':gender', $this->gender);
        $stmt->bindParam(':age', $this->age);
        $stmt->bindParam(':address', $this->address);
        $stmt->bindParam(':contact_no', $this->contact_no);
        $stmt->bindParam(':date_grad', $this->date_grad);
        $stmt->bindParam(':emp_stat', $this->emp_stat);
        $stmt->bindParam(':user_account', $this->user_account);

        $stmt->bindParam(':account_id', $this->account_id);
        $stmt->bindParam(':username', $this->username);
        $stmt->bindParam(':password', $this->password);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    /**
     * Delete a job posting given its id
     *
     * @return boolean true if the job posting was deleted, false otherwise
     */
    function delete()
    {
        $query = "DELETE FROM " . $this->table_name . " WHERE graduate_id = :graduate_id";
        $stmt = $this->conn->prepare($query);

        $this->graduate_id = htmlspecialchars(strip_tags($this->graduate_id));
        $stmt->bindParam(':graduate_id', $this->graduate_id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
