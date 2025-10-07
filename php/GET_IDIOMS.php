<?php
error_reporting(0);
ini_set('display_errors', 0);

header('Content-Type: application/json');

// Database configuration
include('config.php'); // defines $host, $dbname, $dbuser, $dbpass

// Create connection
$conn = new mysqli($host, $dbuser, $dbpass, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode([]);
    exit;
}

// Get today's idioms
$sql = "SELECT phrase, example, usage_context FROM Idioms WHERE teach_date = CURDATE()";
$result = $conn->query($sql);

$response = [];

// Fetch idioms if available
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $response[] = $row;
    }
}

echo json_encode($response, JSON_PRETTY_PRINT);

$conn->close();
?>
