import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var enteredOTP = ""
    @State private var showOTPField = false
    @State private var successMessage = ""
    @State private var errorMessage = ""
    @State private var navigateToResetPage = false
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Forgot Password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                TextField("Enter your registered email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button("Send OTP") {
                    sendOTP(to: email)
                }
                .buttonStyle(.borderedProminent)
                
                if showOTPField {
                    TextField("Enter OTP", text: $enteredOTP)
                        .keyboardType(.numberPad)
                        .submitLabel(.done)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button("Verify OTP") {
                        verifyOTP()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.subheadline)
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .onTapGesture { hideKeyboard() }
            // ✅ Attach navigationDestination here at the container level
            .navigationDestination(isPresented: $navigateToResetPage) {
                ChangePasswordView()
            }
        }
    }
    
    // MARK: - API Calls
    
    func sendOTP(to email: String) {
        guard let url = URL(string: "http://localhost/LanguageLearningApp/forgot_password.php") else {
            errorMessage = "Invalid server URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)"
        request.httpBody = bodyData.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(OTPResponse.self, from: data)
                    if decoded.status == "success" {
                        showOTPField = true
                        errorMessage = ""
                        successMessage = "OTP sent to \(email)"
                    } else {
                        errorMessage = decoded.message ?? "Failed to send OTP"
                        successMessage = ""
                    }
                } catch {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func verifyOTP() {
        guard !enteredOTP.isEmpty else {
            errorMessage = "Please enter OTP"
            return
        }
        
        successMessage = "OTP verified! Redirecting..."
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            navigateToResetPage = true
        }
    }
}

// MARK: - Helpers

struct OTPResponse: Codable {
    let status: String
    let message: String?
    let otp: String? // ⚠️ Not recommended in production
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ForgotPasswordView()
        .environmentObject(AppState())
}
