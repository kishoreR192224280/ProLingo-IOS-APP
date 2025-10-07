<?php
header('Content-Type: application/json');
include('config.php'); // Make sure this file defines $host, $dbname, $dbuser, $dbpass

// Create connection
$conn = new mysqli($host, $dbuser, $dbpass, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Connection failed: ' . $conn->connect_error]);
    exit;
}

// Read input data
$input = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!empty($_POST)) {
        $input = $_POST;
    } else {
        $raw = file_get_contents('php://input');
        $input = json_decode($raw, true);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only POST requests are allowed']);
    exit;
}

// Extract level filter if provided
$level = isset($input['level']) ? strtolower(trim($input['level'])) : 'all';
$whereClause = '';
$params = [];

if ($level !== 'all') {
    $whereClause = "WHERE level = ?";
}

// Prepare and execute query
$query = "SELECT id, question_type, tamil_text, english_text, correct_option_id, level FROM question1 $whereClause ORDER BY id";
$stmt = $conn->prepare($query);

if ($level !== 'all') {
    $stmt->bind_param("s", $level);
}

$stmt->execute();
$result = $stmt->get_result();
$questions = $result->fetch_all(MYSQLI_ASSOC);

$output = [];

foreach ($questions as $q) {
    // Fetch options for each question
    $optionsQuery = "SELECT id, option_text, option_key FROM option1 WHERE question_id = ? ORDER BY option_key";
    $optionsStmt = $conn->prepare($optionsQuery);
    $optionsStmt->bind_param("i", $q['id']);
    $optionsStmt->execute();
    $optionsResult = $optionsStmt->get_result();
    $options = $optionsResult->fetch_all(MYSQLI_ASSOC);

    $optionsArray = [];
    foreach ($options as $opt) {
        $optionsArray[] = [
            'id' => (int)$opt['id'],
            'option_text' => $opt['option_text'],
            'option_key' => $opt['option_key'],
            'is_correct' => ($opt['id'] == $q['correct_option_id'])
        ];
    }

    $output[] = [
        'id' => (int)$q['id'],
        'question_type' => $q['question_type'],
        'tamil_text' => $q['tamil_text'],
        'english_text' => $q['english_text'],
        'level' => $q['level'],
        'options' => $optionsArray
    ];
}

echo json_encode(['success' => true, 'questions' => $output], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

// Close connections
$stmt->close();
$conn->close();
?>
