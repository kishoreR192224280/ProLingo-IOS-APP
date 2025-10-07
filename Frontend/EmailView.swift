import SwiftUI

struct EmailView: View {
    @State private var emailInput: String = ""
    @State private var errorMessage: String? = nil
    @FocusState private var isTextFieldFocused: Bool
    @State private var navigateToPassword = false
    @State private var isNextPressed = false
    
    @EnvironmentObject var registerModel: RegisterModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()
                
                // Title
                Text("Enter your email")
                    .font(.largeTitle).bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)

                // TextField with placeholder inside
                TextField("Enter your email", text: $emailInput)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .focused($isTextFieldFocused)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.red.opacity(0.7), lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.red.opacity(0.05))
                            )
                    )
                    .padding(.horizontal, 30)
                    .shadow(color: .red.opacity(0.1), radius: 5, x: 0, y: 5)
                    .frame(height: 60)
                    .onChange(of: emailInput) { _ in errorMessage = nil }

                // Error message
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red.opacity(0.9))
                        .font(.caption)
                        .padding(.top, 5)
                }

                // Next Button
                Button(action: {
                    if isValidEmail(emailInput) {
                        appState.email = emailInput
                        registerModel.email = emailInput
                        navigateToPassword = true
                    } else {
                        errorMessage = "Please enter a valid email"
                    }
                }) {
                    Text("Next")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.red)
                        )
                        .shadow(color: Color.red.opacity(0.3), radius: 5, x: 0, y: 5)
                        .scaleEffect(isNextPressed ? 0.95 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isNextPressed)
                }
                .padding(.horizontal, 30)
                .disabled(emailInput.isEmpty)
                .opacity(emailInput.isEmpty ? 0.6 : 1)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isNextPressed = true }
                        .onEnded { _ in isNextPressed = false }
                )

                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isTextFieldFocused = true
                }
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
            .navigationDestination(isPresented: $navigateToPassword) {
                PasswordView()
            }
        }
    }

    // MARK: - Email Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailView()
                .environmentObject(AppState())
                .environmentObject(RegisterModel())
        }
    }
}
