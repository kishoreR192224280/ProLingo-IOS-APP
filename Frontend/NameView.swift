import SwiftUI

struct NameView: View {
    @State private var nameInput: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var navigateToAge = false
    @State private var errorMessage: String? = nil
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var registerModel: RegisterModel
    @Environment(\.dismiss) private var dismiss

    @State private var isNextPressed = false
    
    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()
            
            VStack {
                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color.white).shadow(radius: 2))
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.top, 10)
                
                Spacer()
                
                // Title
                Text("What's your name?")
                    .font(.largeTitle).bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                // Text Field with placeholder inside
                TextField("Enter your name", text: $nameInput)
                    .focused($isTextFieldFocused)
                    .padding()
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
                    .onChange(of: nameInput) { _ in errorMessage = nil }
                    .frame(height: 60)
                
                // Error Message
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red.opacity(0.9))
                        .font(.caption)
                        .padding(.top, 5)
                }
                
                // Next Button
                Button(action: {
                    if !nameInput.trimmingCharacters(in: .whitespaces).isEmpty {
                        appState.name = nameInput
                        registerModel.name = nameInput
                        navigateToAge = true
                    } else {
                        errorMessage = "Please enter a valid name"
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
            .navigationDestination(isPresented: $navigateToAge) {
                AgeInputView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NameView()
                .environmentObject(AppState())
                .environmentObject(RegisterModel())
        }
    }
}
