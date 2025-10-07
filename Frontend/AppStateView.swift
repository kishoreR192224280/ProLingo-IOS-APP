import SwiftUI
import Foundation

enum ViewState: String {
    case login
    case home
    case achievement
    case start
}

class AppState: ObservableObject {
    // 🔹 Persistent app states
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("userID") var userId: Int = 0
    @AppStorage("username") var username: String = ""
    @AppStorage("maxId") var maxId: Int = 0
    @Published var isDarkMode: Bool = false
    
    // ✅ Make currentLevel accessible from other views
    @AppStorage("currentLevel") var currentLevel: String = "beginner"
    
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en" {
        didSet {
            // Apply new language immediately
            Bundle.setLanguage(selectedLanguage)
            
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
            objectWillChange.send() // force UI refresh
        }
    }
    
    // 🔹 Published UI states
    @Published var currentView: ViewState = .start
    @Published var showNetworkError: Bool = false
    @Published var currentUser: LoginData? = nil
    
    // 🔹 Temporary form fields
    @Published var name: String = ""
    @Published var age: Int = 0
    @Published var email: String = ""
    @Published var password1: String = ""
    
    // 🔹 Retry action for network issues
    var retryAction: (() -> Void)? = nil

    init() {
        // Apply saved language at startup
        Bundle.setLanguage(selectedLanguage)
        
        // Monitor network connectivity
        NotificationCenter.default.addObserver(
            forName: .networkStatusChanged,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let status = notification.userInfo?["isConnected"] as? Bool {
                self?.showNetworkError = !status
            }
        }
    }
    
    // 🔹 Centralized localization function
    func loc(_ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arguments: args)
    }
    
    // 🔹 Helper functions for level management
    func advanceLevel() {
        switch currentLevel {
        case "beginner":
            currentLevel = "intermediate"
        case "intermediate":
            currentLevel = "advanced"
        default:
            break
        }
    }
    
    func resetLevel() {
        currentLevel = "beginner"
    }
}
