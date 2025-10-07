<?php
// get_achievements.php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include('config.php'); // Ensure $conn is defined

// Check if userId is provided via GET
if (!isset($_GET['userId'])) {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Missing userId parameter"
    ]);
    exit();
}

$userId = (int) $_GET['userId'];

// Prepare SQL
$sql = "SELECT * FROM userAchievements WHERE userId = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "SQL prepare failed: " . $conn->error
    ]);
    exit();
}

$stmt->bind_param("i", $userId);
$stmt->execute();

$result = $stmt->get_result();
$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "success" => true,
    "userId" => $userId,
    "achievements" => $data
]);

$stmt->close();
$conn->close();
?>
