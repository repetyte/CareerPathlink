<?php
// Define the plain text password
$plainPassword = '@D3f3n$3r!93*P@$$w0rd';

// Hash the password
$hashedPassword = password_hash($plainPassword, PASSWORD_BCRYPT);

// Output the hashed password
echo "Hashed Password: " . $hashedPassword . "<br>";

// Simulate user input and verify the password
$userInputPassword = '@D3f3n$3r!93*P@$$w0rd'; // Replace with input from the user
$hashedPasswordFromDatabase = $hashedPassword; // Simulate retrieved hashed password from the database

if (password_verify($userInputPassword, $hashedPasswordFromDatabase)) {
    echo "Password is correct.";
} else {
    echo "Invalid password.";
}
?>

<!-- http://localhost/CareerPathlink/api/career_coaching/hash_password.php -->