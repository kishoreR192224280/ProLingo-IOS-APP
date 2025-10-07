import SwiftUI

struct PrivacyView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var wrongPassword = false
    @State private var isLoading = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top Header with vector1 background
            ZStack(alignment: .top) {
                Image("vector1")
                    .resizable()
                    .scaledToFill()
                    .clipped()
 
                VStack(spacing: 6) {
                    Spacer()
                        .frame(height: 130)
                    
                    ZStack(alignment: .bottomTrailing) {
                        Image("icon")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        
                        Button(action: {
                            // handle edit action
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.blue)
                                .background(Circle().fill(Color.white))
                        }
                        .offset(x: 5, y: 5)
                    }

                    Text("Kishore Kathir")
                        .font(.headline)
                    Text("Newbie")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(height: 250)
            .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 20) {
                StyledTextField(
                    placeholder: NSLocalizedString("name", comment: ""),
                    text: $name,
                    borderColor: .gray
                )
                
                StyledTextField(
                    placeholder: NSLocalizedString("username", comment: ""),
                    text: $username,
                    borderColor: .green,
                    icon: "person.fill"
                )
                
                StyledTextField(
                    placeholder: NSLocalizedString("email", comment: ""),
                    text: $email,
                    borderColor: .gray
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    StyledSecureField(
                        placeholder: NSLocalizedString("password", comment: ""),
                        text: $password,
                        showPassword: $showPassword,
                        borderColor: wrongPassword ? .red : .gray
                    )
                    if wrongPassword {
                        Text(NSLocalizedString("wrong_password", comment: ""))
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("21")
                        .strikethrough(true, color: .gray)
                    Text(NSLocalizedString("age", comment: ""))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(NSLocalizedString("joined_from", comment: ""))
                    Text("5 Jan 2022")
                        .foregroundColor(.black)
                }
                .font(.footnote)
                .padding(.top, 5)
                
                Button(action: saveUser) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    } else {
                        Text(NSLocalizedString("save", comment: ""))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(NSLocalizedString("update_user", comment: "")),
                message: Text(alertMessage),
                dismissButton: .default(Text(NSLocalizedString("ok", comment: "")))
            )
        }
    }
    
    private func saveUser() {
        isLoading = true
        UserService.shared.updateUser(
            id: 3, // example, should be dynamic
            name: name,
            age: 21, // example, should be dynamic
            email: email,
            password: password
        ) { result in
            isLoading = false
            switch result {
            case .success(let response):
                alertMessage = response.message
                showAlert = true
            case .failure(let error):
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

// MARK: - Components

struct StyledTextField: View {
    var placeholder: String
    @Binding var text: String
    var borderColor: Color
    var icon: String? = nil
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
            if let iconName = icon {
                Image(systemName: iconName)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25)
            .stroke(borderColor, lineWidth: 1))
    }
}

struct StyledSecureField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    var borderColor: Color
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            Button(action: { showPassword.toggle() }) {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25)
            .stroke(borderColor, lineWidth: 1))
    }
}

#Preview {
    PrivacyView()
}
