import SwiftUI

struct ChangePasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    
    var passwordsMatch: Bool {
        confirmPassword == newPassword && !confirmPassword.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Back button and title
            HStack {
                Button(action: {
                    // Handle back navigation
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
            }
            
            Text("Change password")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            // New password field
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if isNewPasswordVisible {
                        TextField("New password", text: $newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        SecureField("New password", text: $newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    Button(action: {
                        isNewPasswordVisible.toggle()
                    }) {
                        Image(systemName: isNewPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.green, lineWidth: 1))
                
                Text("New strong password. Super Strong!")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            
            // Confirm password field
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if isConfirmPasswordVisible {
                        TextField("Confirm password", text: $confirmPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        SecureField("Confirm password", text: $confirmPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    Button(action: {
                        isConfirmPasswordVisible.toggle()
                    }) {
                        Image(systemName: isConfirmPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25)
                    .stroke(passwordsMatch ? Color.green : Color.red, lineWidth: 1))
                
                Text(passwordsMatch ? "Both passwords match" : "Both passwords should match")
                    .font(.caption)
                    .foregroundColor(passwordsMatch ? .green : .red)
            }
            
            // Change button
            Button(action: {
                // Handle change password action
            }) {
                Text("Change")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(25)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
