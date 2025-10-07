import SwiftUI

// MARK: - Main View
struct LOGREGView: View {
    @State private var loginNav = false
    @State private var regNav = false
    @State private var isRegisterPressed = false
    @State private var isLoginPressed = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Spacer()
                        
                        // Logo Section
                        ZStack {
                            Image("logobackground")
                                .resizable()
                                .frame(width: 378, height: 267)
                            
                            Image("logo border")
                                .resizable()
                                .frame(width: 159.01, height: 164.01)
                            
                            MyShape()
                                .frame(width: 121.12, height: 127.67)
                                .scaledToFit()
                            
                            Image("logo V")
                                .resizable()
                                .frame(width: 74, height: 80)
                        }
                        .padding()
                        
                        Spacer()
                        
                        // Bottom Sheet
                        VStack(spacing: 20) {
                            Capsule()
                                .fill(Color.white.opacity(0.6))
                                .frame(width: 40, height: 5)
                                .padding(.top, 10)
                            
                            Text("Learn the business language for free!")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Learn the business language\ninteractively at your fingertips!")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                            
                            // Page Indicator
                            HStack(spacing: 8) {
                                Circle().fill(Color.white).frame(width: 8, height: 8)
                                Circle().fill(Color.white.opacity(0.4)).frame(width: 8, height: 8)
                            }
                            .padding(.top, 10)
                            
                            // Buttons
                            HStack {
                                // Register Button
                                Button(action: {
                                    regNav = true
                                }) {
                                    HStack {
                                        Text("Register")
                                            .fontWeight(.semibold)
                                        Image(systemName: "chevron.right")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .scaleEffect(isRegisterPressed ? 0.95 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isRegisterPressed)
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { _ in isRegisterPressed = true }
                                        .onEnded { _ in isRegisterPressed = false }
                                )
                                
                                Spacer()
                                
                                // Login Button
                                Button(action: {
                                    loginNav = true
                                }) {
                                    HStack {
                                        Text("Login")
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                    .fontWeight(.semibold)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                                    .scaleEffect(isLoginPressed ? 0.95 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isLoginPressed)
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { _ in isLoginPressed = true }
                                        .onEnded { _ in isLoginPressed = false }
                                )
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .background(Color.white)
                    .navigationDestination(isPresented: $loginNav) {
                        LoginView()
                    }
                    .navigationDestination(isPresented: $regNav) {
                        CreateProfileView()
                    }
                }
            }
        }
    }
}

// MARK: - Custom corner radius modifier
struct RoundedCorner: Shape {
    var radius: CGFloat = 10.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        LOGREGView()
    }
}
