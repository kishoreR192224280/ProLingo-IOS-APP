<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=utf-8");
mb_internal_encoding('UTF-8');

// Database connection
$conn = new mysqli("localhost", "root", "", "languagelearningapp");

// Check connection
if ($conn->connect_error) {
    die(json_encode([
        "status" => "error",
        "errors" => ["Database connection failed: " . $conn->connect_error]
    ]));
}

$question_id = isset($_GET['id']) ? intval($_GET['id']) : null;

// Prepare query to fetch one question
if ($question_id) {
    $stmt = $conn->prepare("SELECT id, question_text, question_type FROM questions WHERE id = ?");
    $stmt->bind_param("i", $question_id);
} else {
    $stmt = $conn->prepare("SELECT id, question_text, question_type FROM questions ORDER BY RAND() LIMIT 1");
}

$stmt->execute();
$result = $stmt->get_result();

if ($question = $result->fetch_assoc()) {
    $question_id = $question['id'];

    // Fetch options only if it's a normal question
    $options = [];
    if ($question["question_type"] === "normal") {
        $opt_stmt = $conn->prepare("SELECT id, option_text FROM options WHERE question_id = ?");
        $opt_stmt->bind_param("i", $question_id);
        $opt_stmt->execute();
        $opt_result = $opt_stmt->get_result();

        while ($opt = $opt_result->fetch_assoc()) {
            $options[] = $opt;
        }
    }

    // Return JSON (for pronunciation type, options will be empty)
    echo json_encode([
        "question_id"   => $question_id,
        "question"      => $question["question_text"],
        "question_type" => $question["question_type"],
        "options"       => $options
    ]);
} else {
    echo json_encode(["error" => "No question found."]);
}

$conn->close();
?>
