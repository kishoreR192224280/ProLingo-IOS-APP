<?php
header('Content-Type: application/json');
include('config.php'); // This defines $host, $dbname, $dbuser, $dbpass

// Create connection
$conn = new mysqli($host, $dbuser, $dbpass, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]);
    exit;
}

// Get POST data
$user_id = $_POST['user_id'] ?? '';
$level = $_POST['level'] ?? '';
$total_correct = isset($_POST['total_correct']) ? (int)$_POST['total_correct'] : 0;
$total_questions = isset($_POST['total_questions']) ? (int)$_POST['total_questions'] : 0;

if (empty($user_id) || empty($level)) {
    echo json_encode(["status" => "error", "message" => "Missing parameters"]);
    exit;
}

// Prepare statement with ON DUPLICATE KEY UPDATE
$query = "INSERT INTO user_progress (user_id, level, total_correct, total_questions)
          VALUES (?, ?, ?, ?)
          ON DUPLICATE KEY UPDATE
            total_correct = VALUES(total_correct),
            total_questions = VALUES(total_questions),
            date_completed = CURRENT_TIMESTAMP";

$stmt = $conn->prepare($query);

if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
    exit;
}

$stmt->bind_param("ssii", $user_id, $level, $total_correct, $total_questions);

if (!$stmt->execute()) {
    echo json_encode(["status" => "error", "message" => "Execute failed: " . $stmt->error]);
    exit;
}

echo json_encode(["status" => "success", "message" => "Progress saved"]);

$stmt->close();
$conn->close();
?>
