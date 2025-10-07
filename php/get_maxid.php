<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

include('config.php'); // $conn is your mysqli connection

// Allow GET and POST only
if ($_SERVER['REQUEST_METHOD'] !== 'GET' && $_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. You sent: " . $_SERVER['REQUEST_METHOD']
    ]);
    exit();
}

// Table name
$tableName = "applogin";

// SQL query to get the maximum id
$sql = "SELECT MAX(id) AS maxId FROM $tableName";
$result = $conn->query($sql);

if ($result && $row = $result->fetch_assoc()) {
    $maxId = $row['maxId'] ?? 0; // Return 0 if table is empty
    echo json_encode([
        "success" => true,
        "maxId" => (int)$maxId
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Failed to fetch maxId"
    ]);
}

$conn->close();
?>
