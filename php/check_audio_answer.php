<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["status" => "error", "message" => "Invalid request method. Use POST."]);
    exit();
}

$question_id = isset($_POST['question_id']) ? intval($_POST['question_id']) : 0;
$user_answer = isset($_POST['user_answer']) ? trim($_POST['user_answer']) : '';

if ($question_id === 0 || $user_answer === '') {
    echo json_encode(["status" => "error", "message" => "Missing input"]);
    exit;
}

// ✅ Get correct answer
$stmt = $conn->prepare("SELECT option_text FROM options WHERE question_id = ? AND is_correct = 1 LIMIT 1");
if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
    exit;
}
$stmt->bind_param("i", $question_id);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();

if (!$data) {
    echo json_encode(["status" => "error", "message" => "Correct answer not found"]);
    exit;
}

$correct_answer = trim($data['option_text']);

// ✅ Compare case-insensitive
$is_correct = strcasecmp($correct_answer, $user_answer) === 0;

// ✅ Save response
$save = $conn->prepare("INSERT INTO audio_responses (question_id, user_answer, is_correct) VALUES (?, ?, ?)");
if (!$save) {
    echo json_encode(["status" => "error", "message" => "Insert prepare failed: " . $conn->error]);
    exit;
}
$save->bind_param("isi", $question_id, $user_answer, $is_correct);
$save->execute();

// ✅ Send result
echo json_encode([
    "status" => $is_correct ? "correct" : "incorrect",
    "correct_answer" => $correct_answer
]);
?>
