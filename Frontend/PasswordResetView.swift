//
//  PasswordResetView.swift
//  languageapp
//
//  Created by SAIL on 09/07/25.
//


import SwiftUI

struct PasswordResetView: View {
    @EnvironmentObject var appState: AppState

    var email: String
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var message = ""
    @State private var resetSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.bold)

            SecureField("New Password", text: $newPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Button("Reset Password") {
                resetPassword()
            }
            .buttonStyle(.borderedProminent)

            if !message.isEmpty {
                Text(message)
                    .foregroundColor(resetSuccess ? .green : .red)
            }

            Spacer()
        }
        .padding()
    }

    func resetPassword() {
        guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
            message = "Please fill all fields"
            resetSuccess = false
            return
        }

        guard newPassword == confirmPassword else {
            message = "Passwords do not match"
            resetSuccess = false
            return
        }

        guard let url = URL(string: "http://localhost/LanguageLearningApp/forgot_password.php") else {
            message = "Invalid URL"
            resetSuccess = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "email=\(email)&new_password=\(newPassword)"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    message = "Network error: \(error.localizedDescription)"
                    resetSuccess = false
                    return
                }

                guard let data = data else {
                    message = "No data received"
                    resetSuccess = false
                    return
                }

                do {
                    let response = try JSONDecoder().decode(ResetResponse.self, from: data)
                    if response.status == "success" {
                        message = "Password reset successfully! Redirecting to login..."
                        resetSuccess = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            appState.currentView = .login
                        }
                    } else {
                        message = response.message ?? "Reset failed"
                        resetSuccess = false
                    }
                } catch {
                    message = "Decoding error"
                    resetSuccess = false
                }
            }
        }.resume()
    }
}
struct ResetResponse: Codable {
    let status: String
    let message: String?
}
