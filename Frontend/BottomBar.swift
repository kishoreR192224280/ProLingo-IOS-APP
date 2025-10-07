import SwiftUI

struct BarView: View {
    @State private var selectedTab = 0

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var achievementManager: AchievementManager
    @EnvironmentObject var maxIdFetcher: MaxIdFetcher

    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .imageScale(.small)
                    Text("Home").font(.caption2)
                }
                .tag(0)

            LearningpageView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "book.fill" : "book")
                        .imageScale(.small)
                    Text("Learning").font(.caption2)
                }
                .tag(1)

            AchievementView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "trophy.circle.fill" : "trophy.circle")
                        .imageScale(.small)
                    Text("Achievement").font(.caption2)
                }
                .tag(2)

            DescriptionView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "binoculars.fill" : "binoculars")
                        .imageScale(.small)
                    Text("Description").font(.caption2)
                }
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.crop.circle.fill" : "person.crop.circle")
                        .imageScale(.small)
                    Text("Profile").font(.caption2)
                }
                .tag(4)
        }
        .tint(.primary) // ✅ replaces accentColor
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    BarView()
        .environmentObject(AppState())
        .environmentObject(AchievementManager(userId: 0))
}
