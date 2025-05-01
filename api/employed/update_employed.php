<?php
include '../../database.php'; // Include the database connection

// Decode the JSON input from the request
$data = json_decode(file_get_contents("php://input"), true);

// Check if the student number is provided in the request
if (isset($data['student_no'])) {
    // Prepare the SQL query to update the employed_list record
    $query = "UPDATE employed_lists SET 
              last_name = :last_name,
              first_name = :first_name,
              middle_name = :middle_name,
              birthdate = :birthdate,
              age = :age,
              home_address = :home_address,
              personal_email = :personal_email,
              facebook_name = :facebook_name,
              course = :course,
              graduation_date = :graduation_date,
              job_title = :job_title,
              company_name = :company_name,
              company_address = :company_address,
              position = :position,
              start_date = :start_date,
              basic_salary = :basic_salary
              WHERE student_no = :student_no";

    // Prepare and execute the statement
    $stmt = $conn->prepare($query);
    $stmt->execute([
        ':student_no' => $data['student_no'],
        ':last_name' => $data['last_name'],
        ':first_name' => $data['first_name'],
        ':middle_name' => $data['middle_name'],
        ':birthdate' => $data['birthdate'], // Ensure this is in YYYY-MM-DD format
        ':age' => $data['age'],
        ':home_address' => $data['home_address'],
        ':personal_email' => $data['personal_email'],
        ':facebook_name' => $data['facebook_name'],
        ':course' => $data['course'],
        ':graduation_date' => $data['graduation_date'], // Ensure this is in YYYY-MM-DD format
        ':job_title' => $data['job_title'],
        ':company_name' => $data['company_name'],
        ':company_address' => $data['company_address'],
        ':position' => $data['position'],
        ':start_date' => $data['start_date'], // Ensure this is in YYYY-MM-DD format
        ':basic_salary' => $data['basic_salary']
    ]);

    // Return a success message in JSON format
    echo json_encode(["message" => "Employed graduate updated successfully"]);
} else {
    // Return an error message if student_no is missing
    http_response_code(400);
    echo json_encode(["message" => "Invalid data: student_no is required"]);
}
?>
