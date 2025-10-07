<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Ensure $conn is set

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST.",
        "data" => []
    ]);
    exit();
}

// Use $_POST when form is urlencoded
if (isset($_POST['selected_option']) && isset($_POST['correct_answer'])) {
    $selected = $_POST['selected_option'];
    $correct = $_POST['correct_answer'];

    if ($selected === $correct) {
        echo json_encode([
            "status" => "success",
            "message" => "Amazing!",
            "answer" => $correct
        ]);
    } else {
        echo json_encode([
            "status" => "fail",
            "message" => "Ups.. that's wrong",
            "answer" => $correct
        ]);
    }
} else {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Missing selected_option or correct_answer"
    ]);
}
?>
