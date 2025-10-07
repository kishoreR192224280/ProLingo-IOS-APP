<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Ensure $conn is defined

// Allow only POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST.",
        "data" => []
    ]);
    exit();
}

// Required fields
$required = ['name', 'age', 'email', 'password'];
foreach ($required as $field) {
    if (!isset($_POST[$field]) || empty(trim($_POST[$field]))) {
        echo json_encode([
            "success" => false,
            "message" => "Missing or empty field: $field",
            "data" => []
        ]);
        exit();
    }
}

// Sanitize and assign inputs
$name = $conn->real_escape_string(trim($_POST['name']));
$age = intval($_POST['age']);
$email = $conn->real_escape_string(trim($_POST['email']));
$password = $conn->real_escape_string(trim($_POST['password'])); // Optionally hash

// Optional: Password hashing for security
// $password = password_hash(trim($_POST['password']), PASSWORD_BCRYPT);

// Check if email already exists
$check_sql = "SELECT id FROM applogin WHERE email = '$email'";
$check_result = $conn->query($check_sql);
if ($check_result && $check_result->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "Email already exists.",
        "data" => []
    ]);
    exit();
}

// Insert new user
$insert_sql = "INSERT INTO applogin (name, age, email, password) VALUES ('$name', $age, '$email', '$password')";
if ($conn->query($insert_sql)) {
    echo json_encode([
        "success" => true,
        "message" => "User registered successfully.",
        "data" => [
            "id" => $conn->insert_id,
            "name" => $name,
            "age" => $age,
            "email" => $email,
            "password" => $password
        ]
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Registration failed: " . $conn->error,
        "data" => []
    ]);
}
?>
