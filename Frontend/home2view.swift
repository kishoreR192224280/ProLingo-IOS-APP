import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var achievementManager: AchievementManager
    
    let targetHours: Double = 10.0
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack {
                // MARK: Header
                ZStack {
                    Color.red
                        .frame(height: 280)
                        .ignoresSafeArea()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(String(format: NSLocalizedString("hi_user", comment: ""), appState.username))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(NSLocalizedString("learn_quicker", comment: ""))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Image("homelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 160)
                            .padding(.trailing)
                    }
                }
                
                // MARK: Levels
                VStack(spacing: 24) {
                    Text(NSLocalizedString("language_being_learned", comment: ""))
                        .foregroundColor(.primary)
                        .font(.system(size: 22, weight: .semibold))
                    
                    HStack(spacing: 50) {
                        LevelCard(level: 7, participants: NSLocalizedString("participants_7k", comment: ""))
                        LevelCard(level: 5, participants: NSLocalizedString("participants_5k", comment: ""))
                    }
                }
                .padding(.top, 16)
                
                // MARK: Progress
                VStack(spacing: 10) {
                    HStack {
                        Image("bus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(NSLocalizedString("business_english", comment: ""))
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                            
                            // Progress calculation
                            let hoursProgress = min(achievementManager.totalLearnedHours / targetHours, 1.0)
                            let achievementsProgress = Double(achievementManager.achievementsCompleted) / 5.0
                            let overallProgress = (hoursProgress + achievementsProgress) / 2.0
                            
                            ProgressView(value: overallProgress)
                                .tint(.green)
                            
                            Text(String(format: NSLocalizedString("progress_percent", comment: ""), Int(overallProgress * 100)))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    .shadow(radius: 3)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
    }
}

// MARK: - Level Card
struct LevelCard: View {
    var level: Int
    var participants: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(String(format: NSLocalizedString("level_format", comment: ""), level))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(participants)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.9))
            
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
        }
        .frame(width: 140, height: 100)
        .background(Color.green)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(AppState())
                .environmentObject(AchievementManager(userId: 1))
                .preferredColorScheme(.light)
        }
    }
}
