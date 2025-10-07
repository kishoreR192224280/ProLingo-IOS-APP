<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=utf-8");
mb_internal_encoding('UTF-8');

// Database connection
$db = new mysqli('localhost', 'username', 'password', 'database_name');
if ($db->connect_error) {
    die(json_encode(["status" => "error", "errors" => ["Database connection failed"]]));
}
$db->set_charset('utf8mb4');
$db->query("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci");

// Get and sanitize input
$word = isset($_POST['word']) ? trim($_POST['word']) : '';
$pronounciation = isset($_POST['pronounciation']) ? trim($_POST['pronounciation']) : '';

// Validation functions
function isValidWord($word) {
    return preg_match('/^[a-zA-Z\-]{1,50}$/', $word);
}

function isValidPronounciation($pronounciation) {
    $ipa_pattern = '/^[\p{L}\p{M}\s\'\-,.ˈˌːʷʰˑʱʲʴʵʶʷʸʹʺʻʽʾʿˀˁ˂˃˄˅ˆˇˈˉˊˋˌˍˎˏːˑ˒˓˔˕˖˗˘˙˚˛˜˝˞˟ˠˡˢˣˤ˥˦˧˨˩˪˫ˬ˭ˮ˯˰˱˲˳˴˵˶˷˸˹˺˻˼˽˾˿‿‖↗↘()⫽⫾{}\[\]]+$/u';
    return preg_match($ipa_pattern, $pronounciation) 
           && mb_strlen($pronounciation) >= 1 
           && mb_strlen($pronounciation) <= 100;
}

// Validate input
$errors = [];
if (empty($word)) {
    $errors[] = "Word is required";
} elseif (!isValidWord($word)) {
    $errors[] = "Invalid word. Only letters and hyphens allowed (1-50 characters)";
}

if (empty($pronounciation)) {
    $errors[] = "Pronunciation is required";
} elseif (!isValidPronounciation($pronounciation)) {
    $errors[] = "Invalid pronunciation. Only letters, spaces, apostrophes, and standard IPA symbols allowed (1-100 characters)";
}

// Process if valid
if (empty($errors)) {
    try {
        $stmt = $db->prepare("INSERT INTO words (word, pronounciation) VALUES (?, ?)");
        $stmt->bind_param("ss", $word, $pronounciation);
        
        if ($stmt->execute()) {
            echo json_encode([
                "status" => "success",
                "message" => "Entry added successfully",
                "data" => [
                    "word" => $word,
                    "pronounciation" => $pronounciation,
                    "id" => $stmt->insert_id
                ]
            ]);
        } else {
            throw new Exception("Database insertion failed");
        }
    } catch (Exception $e) {
        $errors[] = $e->getMessage();
        error_log("Database error: " . $e->getMessage());
    }
}

// Return errors if any
if (!empty($errors)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "errors" => $errors
    ]);
}

$db->close();
?>