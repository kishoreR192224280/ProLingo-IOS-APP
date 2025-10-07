<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=utf-8");
mb_internal_encoding('UTF-8');

// Database connection
$conn = new mysqli("localhost", "root", "", "languagelearningapp");

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "errors" => ["Database connection failed: " . $conn->connect_error]]));
}
// Read POST data from form-data
$question_id = $_POST['question_id'];
$selected_option_id = $_POST['selected_option_id'];

// Check if selected option is correct
$stmt = $conn->prepare("SELECT is_correct FROM options WHERE id = ? AND question_id = ?");
$stmt->bind_param("ii", $selected_option_id, $question_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    $is_correct = $row['is_correct'];
    echo json_encode([
        "question_id" => $question_id,
        "selected_option_id" => $selected_option_id,
        "correct" => $is_correct ? true : false,
        "message" => $is_correct ? "Correct Answer!" : "Wrong Answer!"
    ]);
} else {
    echo json_encode(["error" => "Invalid question or option"]);
}

$conn->close();
?>
