<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Enable error reporting for debugging (optional in development)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Load PHPMailer classes
require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';
require 'config.php';  // Database connection

// CORS & JSON headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = $_POST['email'] ?? '';

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(["status" => "error", "message" => "Invalid email"]);
        exit;
    }

    // ✅ Check if email exists in database
    $stmt = $conn->prepare("SELECT id FROM applogin WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows === 0) {
        echo json_encode(["status" => "error", "message" => "User with this email does not exist"]);
        $stmt->close();
        $conn->close();
        exit;
    }
    $stmt->close();

    // ✅ Email exists, continue sending OTP
    $otp = rand(100000, 999999);

    $mail = new PHPMailer(true);
    try {
        // SMTP Configuration
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'mailingkishore72@gmail.com';     // ✅ Your Gmail
        $mail->Password = 'mtzgvrubiayqtbli';           // ✅ App Password
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Email Settings
        $mail->setFrom('mailingkishore72@gmail.com', 'Language Learning App'); // ✅ Your Gmail
        $mail->addAddress($email);

        $mail->isHTML(true);
        $mail->Subject = 'Your OTP for app';
        $mail->Body    = "
            <p>Hi,</p>
            <p>Your OTP is <strong>$otp</strong></p>
            <p>Use it to reset your password.</p>
            <br>
            <p>Thanks,<br>app Team</p>
        ";

        $mail->send();
        echo json_encode([
            "status" => "success",
            "message" => "OTP sent successfully",
            "otp" => (string)$otp
        ]);
    } catch (Exception $e) {
        echo json_encode([
            "status" => "error",
            "message" => "Mailer Error: {$mail->ErrorInfo}"
        ]);
    }

    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>
