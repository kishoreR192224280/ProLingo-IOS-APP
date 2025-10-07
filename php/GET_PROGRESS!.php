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

// Get user_id from POST data
$user_id = $_POST['user_id'] ?? '';

if (empty($user_id)) {
    echo json_encode(["status" => "error", "message" => "User ID is missing"]);
    exit;
}

// Prepare and execute query
$query = "SELECT level, total_correct AS totalCorrect, total_questions AS totalQuestions FROM user_progress WHERE user_id = ?";
$stmt = $conn->prepare($query);

if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
    exit;
}

$stmt->bind_param("s", $user_id);

if (!$stmt->execute()) {
    echo json_encode(["status" => "error", "message" => "Execute failed: " . $stmt->error]);
    exit;
}

$result = $stmt->get_result();
$progress = [];

while ($row = $result->fetch_assoc()) {
    $progress[] = $row;
}

echo json_encode(["status" => "success", "data" => $progress], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

$stmt->close();
$conn->close();
?>
