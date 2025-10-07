import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToNameView = false

    @EnvironmentObject var appState: AppState
    @AppStorage("username") var username: String = ""
    @AppStorage("useremail") var useremail: String = ""
    @AppStorage("userID") var userID: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 28) {
                    // MARK: Logo
                    ZStack {
                        Image("logobackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 250)
                        
                        Image("logo border")
                            .resizable()
                            .frame(width: 160, height: 165)
                        
                        MyShape()
                            .frame(width: 120, height: 128)
                            .foregroundColor(.black)
                        
                        Image("logo V")
                            .resizable()
                            .frame(width: 74, height: 80)
                    }
                    .padding(.top, 20)
                    
                    // MARK: Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        TextField("Email Address", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1.3)
                            )
                    }
                    
                    // MARK: Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack {
                            Group {
                                if isPasswordVisible {
                                    TextField("Password", text: $password)
                                        .foregroundColor(.black)
                                } else {
                                    SecureField("Password", text: $password)
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Button(action: { isPasswordVisible.toggle() }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1.3)
                        )
                    }
                    
                    // MARK: Login Button
                    Button(action: login) {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(25)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // MARK: Register Link
                    HStack {
                        Text("Don’t have an account?")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                        
                        Button("Register") {
                            navigateToNameView = true
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.red)
                    }
                    .padding(.bottom, 12)
                }
                .padding(.horizontal)
                .toolbar(.hidden) // ✅ Hide back button for consistency
                .navigationDestination(isPresented: $navigateToNameView) {
                    NameView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Login Failed"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                // MARK: No Internet Overlay
                if appState.showNetworkError {
                    Color.white.opacity(0.9)
                        .ignoresSafeArea()
                        .zIndex(1)
                    
                    noInternetView {
                        appState.showNetworkError = false
                        appState.retryAction?()
                    }
                    .zIndex(2)
                    .transition(.opacity)
                }
            }
        }
    }
    
    // MARK: - Login Function
    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Email and Password cannot be empty."
            showAlert = true
            return
        }
        
        let param = ["email": email, "password": password]
        
        APIHandler.shared.postAPIValues(
            type: LoginModel.self,
            apiUrl: "http://localhost/LanguageLearningApp/login.php",
            method: "POST",
            formData: param
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loginResponse):
                    if loginResponse.success, let user = loginResponse.data.first {
                        // ✅ Save user info
                        userID = user.id
                        username = user.name
                        useremail = user.email
                        
                        // ✅ Update AppState
                        appState.loggedIn = true
                    } else {
                        alertMessage = loginResponse.message
                        showAlert = true
                    }
                case .failure:
                    alertMessage = "Server error. Please try again."
                    showAlert = true
                    
                    // Retry option
                    appState.retryAction = { self.login() }
                    appState.showNetworkError = true
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
    }
}
