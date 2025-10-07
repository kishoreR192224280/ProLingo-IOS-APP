import SwiftUI

struct AgeInputView: View {
    @State private var ageInput: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var navigateToEmail = false
    @State private var errorMessage: String? = nil
    @State private var isNextPressed = false
    
    @EnvironmentObject var registerModel: RegisterModel

    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()
                
                // Title
                Text("How old are you?")
                    .font(.largeTitle).bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)

                // TextField with placeholder inside
                TextField("Enter your age", text: $ageInput)
                    .keyboardType(.numberPad)
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
                    .onChange(of: ageInput) { _ in
                        errorMessage = nil
                    }

                // Error message
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red.opacity(0.9))
                        .font(.caption)
                        .padding(.top, 5)
                }

                // Next Button
                Button(action: {
                    if let parsed = Int(ageInput), parsed >= 5, parsed <= 120 {
                        registerModel.age = parsed
                        navigateToEmail = true
                    } else {
                        errorMessage = "Please enter a valid age"
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
            .navigationDestination(isPresented: $navigateToEmail) {
                EmailView()
            }
        }
    }
}

struct AgeInputView_Previews: PreviewProvider {
    static var previews: some View {
        AgeInputView()
            .environmentObject(AppState())
            .environmentObject(RegisterModel())
    }
}
