<?php
// save_achievement.php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include('config.php'); // $conn is defined here

// Only allow POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

// Read input from form-data (not raw JSON)
if (
    !isset($_POST['userId']) ||
    !isset($_POST['totalAttempts']) ||
    !isset($_POST['fullScoreCount']) ||
    !isset($_POST['totalCorrectAnswers']) ||
    !isset($_POST['fastAnswers'])
) {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Missing required fields"
    ]);
    exit();
}

$userId = (int)$_POST['userId'];
$totalAttempts = (int)$_POST['totalAttempts'];
$fullScoreCount = (int)$_POST['fullScoreCount'];
$totalCorrectAnswers = (int)$_POST['totalCorrectAnswers'];
$fastAnswers = (int)$_POST['fastAnswers'];

// Save or update achievement row for the user
$sql = "
    INSERT INTO userAchievements (userId, totalAttempts, fullScoreCount, totalCorrectAnswers, fastAnswers)
    VALUES (?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
        totalAttempts = VALUES(totalAttempts),
        fullScoreCount = VALUES(fullScoreCount),
        totalCorrectAnswers = VALUES(totalCorrectAnswers),
        fastAnswers = VALUES(fastAnswers)
";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "SQL prepare failed: " . $conn->error]);
    exit();
}

$stmt->bind_param("iiiii", $userId, $totalAttempts, $fullScoreCount, $totalCorrectAnswers, $fastAnswers);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Achievement saved successfully"]);
} else {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Execution failed: " . $stmt->error]);
}

$stmt->close();
$conn->close();
