<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Assumes $conn is defined

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST.",
        "data" => []
    ]);
    exit();
}

// Validate input
if (empty($_POST['email']) || empty($_POST['password'])) {
    echo json_encode([
        "success" => false,
        "message" => "Email and password are required.",
        "data" => []
    ]);
    exit();
}

// Sanitize input
$email = $conn->real_escape_string($_POST['email']);
$password = $conn->real_escape_string($_POST['password']); // Not hashed

// Check user credentials
$sql = "SELECT id, name, age, email FROM applogin WHERE email = '$email' AND password = '$password'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "message" => "Login successful.",
        "data" => [$user]
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid email or password.",
        "data" => []
    ]);
}
?>
