import SwiftUI

struct PasswordView: View {
    @State private var passwordInput: String = ""
    @State private var showPassword: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var isTextFieldFocused: Bool
    @State private var isFinishPressed = false
    
    @EnvironmentObject var registerModel: RegisterModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()
                
                // Title
                Text("Set your password")
                    .font(.largeTitle).bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                // Password field
                HStack {
                    if showPassword {
                        TextField("Enter your password", text: $passwordInput)
                            .focused($isTextFieldFocused)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    } else {
                        SecureField("Enter your password", text: $passwordInput)
                            .focused($isTextFieldFocused)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .frame(height: 60)
                .frame(maxWidth: 350)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.red.opacity(0.7), lineWidth: 1.5)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.red.opacity(0.05))
                        )
                )
                .padding(.bottom, 12)
                .shadow(color: .red.opacity(0.1), radius: 5, x: 0, y: 5)
                
                // Error messages
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red.opacity(0.9))
                        .font(.caption)
                        .padding(.bottom, 5)
                }
                
                if let error = registerModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.bottom, 12)
                }
                
                // Finish Button
                Button(action: {
                    if isValidPassword(passwordInput) {
                        registerModel.password = passwordInput
                        appState.password1 = passwordInput
                        registerModel.registerUser(appState: appState)
                    } else {
                        errorMessage = "Password must be at least 6 characters and include a number"
                    }
                }) {
                    Text("Finish")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.red)
                        )
                        .shadow(color: Color.red.opacity(0.3), radius: 5, x: 0, y: 5)
                        .scaleEffect(isFinishPressed ? 0.95 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFinishPressed)
                }
                .padding(.horizontal, 30)
                .disabled(passwordInput.isEmpty)
                .opacity(passwordInput.isEmpty ? 0.6 : 1)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isFinishPressed = true }
                        .onEnded { _ in isFinishPressed = false }
                )
                
                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isTextFieldFocused = true
                }
            }
            .navigationDestination(isPresented: $registerModel.isRegistered) {
                BarView()
            }

            // 🔥 No Internet Overlay
            if appState.showNetworkError {
                noInternetView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: appState.showNetworkError)
    }

    // MARK: - Password Validation
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PasswordView()
                .environmentObject(AppState())
                .environmentObject(RegisterModel())
        }
    }
}
