import SwiftUI

struct SettingView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @EnvironmentObject var achievementManager: AchievementManager
    @EnvironmentObject var appState: AppState   // ✅ use AppState for language

    // Map codes to display names
    let languages = [
        "en": "English",
        "ta": "Tamil",
        "hi": "Hindi"
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Language Section
                SectionView(title: appState.loc("language")) {
                    Picker(selection: $appState.selectedLanguage) {
                        ForEach(languages.keys.sorted(), id: \.self) { code in
                            Text(languages[code] ?? code)
                                .tag(code) // ✅ use code for tag
                        }
                    } label: {
                        Text(appState.loc("choose_language"))
                    }
                    .pickerStyle(.menu) // 👈 dropdown style
                    .onChange(of: appState.selectedLanguage) { newCode in
                        applyLanguage(newCode)
                    }
                    .padding()
                }

                // Achievements Section
                SectionView(title: appState.loc("achievements")) {
                    SettingsRow(title: "\(appState.loc("total_learn_time")): \(String(format: "%.2f", achievementManager.totalLearnedHours)) hrs")
                    SettingsRow(title: "\(appState.loc("achievements_unlocked")): \(achievementManager.achievementsCompleted)/5")
                }

                // Other Settings Section
                SectionView(title: appState.loc("other_settings")) {
                    Toggle(isOn: $isDarkMode) {
                        Text(appState.loc("dark_mode"))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: Text(appState.loc("privacy_policy"))) {
                        SettingsRow(title: appState.loc("privacy_policy"))
                            .foregroundStyle(.primary)
                    }
                    NavigationLink(destination: Text(appState.loc("terms_conditions"))) {
                        SettingsRow(title: appState.loc("terms_conditions"))
                            .foregroundStyle(.primary)
                    }
                }

                Spacer()
            }
            .padding(.top)
            .navigationBarTitle(appState.loc("settings"), displayMode: .inline)
        }
    }

    private func applyLanguage(_ code: String) {
        Bundle.setLanguage(code) // ✅ direct
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
}


// MARK: - SectionView
struct SectionView<Content: View>: View {
    var title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            VStack(spacing: 0) {
                content()
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 1)
        }
    }
}

// MARK: - SettingsRow
struct SettingsRow: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

// MARK: - Preview
#Preview {
    SettingView()
        .environmentObject(AchievementManager(userId: 0))
        .environmentObject(AppState())  // ✅ inject AppState here
}
