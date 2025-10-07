import SwiftUI

struct ProfileView: View {
    @AppStorage("loggedIn") var loggedIn: Bool = true
    @AppStorage("userID") var userID: Int = 0
    @AppStorage("useremail") var useremail: String = ""
    @State private var navigateToRepassword = false
    @State private var navigateToSettings = false
    @State private var navigateToprofileedit = false
    @State var showLogoutAlert: Bool = false
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var achievementManager: AchievementManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 🔝 Top Section
                ZStack(alignment: .center) {
                    Image("vector")
                        .ignoresSafeArea()
                        .frame(height: 250)
                    
                    VStack(spacing: 10) {
                        
                        // Profile Image + Edit Icon
                        ZStack(alignment: .bottomTrailing) {
                            Image("icon")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.top, 120)
                            
                            Button(action: {
                                navigateToprofileedit = true
                            }) {
                                Image("pencil")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(.blue)
                                    .background(Circle().fill(Color.white))
                                    .offset(x: 5, y: 5)
                            }
                        }
                        
                        Text(appState.username)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                        
                        Text(appState.loc("profile_newbie"))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 40) {
                            StatView(
                                value: "\(String(format: "%.1f", achievementManager.totalLearnedHours)) hrs",
                                label: appState.loc("profile_total_learn")
                            )
                            StatView(
                                value: "\(achievementManager.achievementsCompleted)",
                                label: appState.loc("profile_achievements")
                            )
                            StatView(
                                value: "2",
                                label: appState.loc("profile_language")
                            )
                        }
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    }
                }
                
                // ⚙️ Dashboard Items
                VStack(spacing: 20) {
                    Button(action: {
                        navigateToSettings = true
                    }) {
                        DashboardItem(
                            icon: "gearshape.fill",
                            color: .blue,
                            title: appState.loc("profile_settings")
                        )
                    }
                    Button(action:{
                        
                    }) {
                        DashboardItem(
                            icon: "trophy.fill",
                            color: .yellow,
                            title: appState.loc("profile_achievements_title"),
                            badge: "\(achievementManager.achievementsCompleted) New",
                            badgeColor: .blue
                        )
                    }
                    Button(action:{
                        
                    }) {
                        DashboardItem(
                            icon: "person.fill",
                            color: .gray,
                            title: appState.loc("profile_privacy"),
                            badge: appState.loc("profile_privacy_badge"),
                            badgeColor: .orange
                        )
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding()
                
                Spacer()
                
                // 🧾 My Account & Logout Section
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray)
                        .frame(width: 280, height: 130)
                    
                    VStack(spacing: 20) {
                        Text(appState.loc("profile_my_account"))
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top)
                        
                        Button(appState.loc("profile_reset_password")) {
                            navigateToRepassword = true
                        }
                        .foregroundColor(.blue)
                        
                        Button(action: {
                            showLogoutAlert = true
                        }) {
                            Text(appState.loc("profile_logout"))
                                .foregroundColor(.red)
                        }
                        .alert(appState.loc("profile_logout_alert"), isPresented: $showLogoutAlert) {
                            Button(appState.loc("profile_logout"), role: .destructive) {
                                withAnimation {
                                    userID = 0
                                    useremail = ""
                                    loggedIn = false
                                    
                                    appState.loggedIn = false
                                    appState.currentView = .login
                                }
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                        .padding(.bottom)
                    }
                }
                
                Spacer()
            }
            .background(Color(.white))
            .navigationDestination(isPresented: $navigateToRepassword) {
                ForgotPasswordView()
            }
            .navigationDestination(isPresented: $navigateToSettings) {
                SettingView()
            }
            .navigationDestination(isPresented: $navigateToprofileedit){
                PrivacyView()
            }
        }
    }
}

// 📊 Stat View
struct StatView: View {
    let value: String
    let label: String

    var body: some View {
        VStack {
            Text(value)
                .font(.headline)
                .bold()
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// 🧩 Dashboard Item
struct DashboardItem: View {
    let icon: String
    let color: Color
    let title: String
    var badge: String? = nil
    var badgeColor: Color? = nil

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: icon).foregroundColor(.white))

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            if let badge = badge, let badgeColor = badgeColor {
                Text(badge)
                    .font(.caption)
                    .padding(6)
                    .background(badgeColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

// 📱 Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppState())
            
    }
}
