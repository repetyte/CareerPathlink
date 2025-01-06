<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Database connection
$conn = new mysqli("localhost", "root", "", "ccms_db");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed: " . $conn->connect_error]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Log the $_FILES array for debugging
    error_log(print_r($_FILES, true));  // Log the file array for debugging

    // Check if file and student_no are present in the request
    if (!isset($_POST['student_no']) || !isset($_FILES['file'])) {
        echo json_encode(["success" => false, "message" => "Missing student number or file."]);
        exit;
    }

    $student_no = $_POST['student_no'];
    $file = $_FILES['file'];

    // Check for file upload errors
    if ($file['error'] != UPLOAD_ERR_OK) {
        echo json_encode(["success" => false, "message" => "File upload error: " . $file['error']]);
        exit;
    }

    // Log the file details for debugging
    error_log("File Details: " . print_r($file, true));  // Log the file array for debugging

    // If file is not empty and student_no is not empty
    if (!empty($file) && !empty($student_no)) {
        $target_dir = "uploads/";

        // Ensure the uploads directory exists
        if (!is_dir($target_dir)) {
            if (!mkdir($target_dir, 0777, true)) {
                echo json_encode(["success" => false, "message" => "Failed to create upload directory."]);
                exit;
            }
        }

        // Add a unique identifier to the file name (e.g., using timestamp or random string)
        $fileExtension = strtolower(pathinfo($file["name"], PATHINFO_EXTENSION));
        $newFileName = $student_no . "_" . time() . "." . $fileExtension; // Add student number + timestamp for uniqueness
        $target_file = $target_dir . $newFileName;

        // Allow certain file formats
        $allowed_types = ['pdf', 'doc', 'docx'];
        if (!in_array($fileExtension, $allowed_types)) {
            echo json_encode(["success" => false, "message" => "Invalid file format. Only PDF, DOC, and DOCX are allowed."]);
            exit;
        }

        // Attempt to move the uploaded file
        if (move_uploaded_file($file["tmp_name"], $target_file)) {
            // Insert record into the database with timestamp
            $stmt = $conn->prepare("INSERT INTO cv_uploads (student_no, file_name, upload_path, uploaded_at) VALUES (?, ?, ?, NOW())");

            if ($stmt === false) {
                echo json_encode([
                    "success" => false, 
                    "message" => "SQL Error: " . $conn->error
                ]);
                exit;
            }

            $stmt->bind_param("sss", $student_no, $newFileName, $target_file);
            $execute_result = $stmt->execute();

            if ($execute_result) {
                echo json_encode([
                    "success" => true,
                    "message" => "CV uploaded successfully!",
                    "uploaded_at" => date("Y-m-d H:i:s")  // Return the timestamp as well
                ]);
            } else {
                echo json_encode(["success" => false, "message" => "Failed to save record in database: " . $stmt->error]);
            }
            $stmt->close();
        } else {
            echo json_encode(["success" => false, "message" => "Failed to upload file."]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Missing student number or file."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
}

$conn->close();
?>
