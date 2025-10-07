<?php
// update_user.php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Ensure $conn is defined

// Allow only POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "status" => "error",
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

// Detect whether data is JSON or form-data
$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);

// If JSON decode failed, fallback to form-data ($_POST)
if (!is_array($data) || empty($data)) {
    $data = $_POST;
}

// Validate required fields
if (
    !isset($data['id']) ||
    !isset($data['name']) ||
    !isset($data['age']) ||
    !isset($data['email']) ||
    !isset($data['password'])
) {
    echo json_encode([
        "status" => "error",
        "message" => "Missing required fields"
    ]);
    exit;
}

// Extract and sanitize
$id       = intval($data['id']);
$name     = trim($data['name']);
$age      = intval($data['age']);
$email    = trim($data['email']);
$password = trim($data['password']); // Recommend hashing in production
// $password = password_hash($password, PASSWORD_BCRYPT);

// Prepare SQL statement
$sql = "UPDATE applogin SET name = ?, age = ?, email = ?, password = ? WHERE id = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode([
        "status" => "error",
        "message" => "Prepare failed: " . $conn->error
    ]);
    exit;
}

$stmt->bind_param("sissi", $name, $age, $email, $password, $id);

if ($stmt->execute()) {
    echo json_encode([
        "status" => "success",
        "message" => "User updated successfully"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Update failed: " . $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>

