import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationStack {
            Group {
                if appState.showNetworkError {
                    noInternetView {
                        appState.showNetworkError = false
                        appState.retryAction?()

                        // ✅ Restore proper view after retry
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            appState.currentView = appState.loggedIn ? .home : .login
                        }
                    }
                } else if appState.loggedIn {
                    BarView()
                } else {
                    switch appState.currentView {
                    case .home, .achievement:
                        BarView()
                    case .login:
                        LoginView()
                    case .start:
                        splashView()
                    }
                }
            }
            .onChange(of: networkMonitor.isConnected) { connected in
                // ✅ Auto-update if network status changes
                if !connected {
                    appState.showNetworkError = true
                } else {
                    appState.showNetworkError = false
                }
            }
        }
    }
}
