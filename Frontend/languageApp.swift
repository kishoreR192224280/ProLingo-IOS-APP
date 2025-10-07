import SwiftUI

@main
struct LanguageLearningApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var registerModel = RegisterModel()
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var idiomsFetcher = IdiomsFetcher()
    @StateObject private var achievementManager = AchievementManager(userId: 0)
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentViewSelector()
                .environmentObject(appState)
                .environmentObject(registerModel)
                .environmentObject(networkMonitor)
                .environmentObject(achievementManager)
                .environmentObject(idiomsFetcher)
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .onChange(of: appState.userId) { newUserId in
                    achievementManager.userId = newUserId
                    achievementManager.loadAchievements()
                }
                // 👇 Forces full view reload on language change
                .id(appState.selectedLanguage)
        }
    }

    @ViewBuilder
    private func ContentViewSelector() -> some View {
        if appState.loggedIn {
            RootView()
        } else {
            RootView()
        }
    }
}
