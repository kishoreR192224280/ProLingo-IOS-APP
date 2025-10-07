<?php
header('Content-Type: application/json');
include('config.php');

try {
    $pdo = new PDO(
        "mysql:host=127.0.0.1;dbname=$dbname;charset=utf8",
        $username,
        $password
    );
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}

// Detect input
$input = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!empty($_POST)) {
        $input = $_POST; // form-data
    } else {
        $input = json_decode(file_get_contents('php://input'), true);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

// Validate
if (empty($input['question_id']) || empty($input['option_text'])) {
    echo json_encode(['success' => false, 'message' => 'Missing question_id or option_text']);
    exit;
}

$question_id = (int)$input['question_id'];
$option_text = trim($input['option_text']);

// Get the correct option_id from question1
$query = "SELECT correct_option_id FROM question1 WHERE id = :question_id";
$stmt = $pdo->prepare($query);
$stmt->execute(['question_id' => $question_id]);
$correct = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$correct || !$correct['correct_option_id']) {
    echo json_encode(['success' => false, 'message' => 'Question or correct option not found']);
    exit;
}

// Fetch the correct option text
$optQuery = "SELECT option_text FROM option1 WHERE id = :id";
$optStmt = $pdo->prepare($optQuery);
$optStmt->execute(['id' => $correct['correct_option_id']]);
$correctOption = $optStmt->fetch(PDO::FETCH_ASSOC);

if (!$correctOption) {
    echo json_encode(['success' => false, 'message' => 'Correct option not found']);
    exit;
}

// Compare user input with correct text (case-insensitive)
$isCorrect = (strcasecmp($option_text, $correctOption['option_text']) === 0);

echo json_encode([
    'success' => true,
    'question_id' => $question_id,
    'user_answer' => $option_text,
    'correct_answer' => $correctOption['option_text'],
    'is_correct' => $isCorrect
], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
?>
