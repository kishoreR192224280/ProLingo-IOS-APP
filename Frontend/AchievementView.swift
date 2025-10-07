import SwiftUI
import AVFoundation

struct AchievementView: View {
    @EnvironmentObject var achievementManager: AchievementManager
    
    private func loc(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(loc("achievement_title"))
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                // Circular Progress & Total Achievements
                HStack {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                            .frame(width: 80, height: 80)
                        
                        Circle()
                            .trim(from: 0.0, to: achievementManager.achievementProgress)
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 80, height: 80)
                        
                        Text("\(Int(achievementManager.achievementProgress * 100)) %")
                            .foregroundColor(.primary)
                            .font(.headline)
                            .bold()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(loc("total_achievements")) : \(achievementManager.achievementsCompleted)")
                            .bold()
                            .foregroundColor(.primary)
                        Text(loc("great_job_message"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.secondarySystemBackground)))
                
                // Cards
                AchievementCard(
                    icon: "graduationcap.fill",
                    title: loc("studious_title"),
                    description: loc("studious_desc"),
                    color: Color.blue.opacity(0.15),
                    stars: min(achievementManager.totalAttempts / 2, 5)
                )
                
                AchievementCard(
                    icon: "timer",
                    title: loc("quickie_title"),
                    description: loc("quickie_desc"),
                    color: Color.yellow.opacity(0.25),
                    stars: min(achievementManager.fastAnswers / 2, 5)
                )
                
                AchievementCard(
                    icon: "flag.fill",
                    title: loc("ambitious_title"),
                    description: loc("ambitious_desc"),
                    color: Color.green.opacity(0.2),
                    stars: min(achievementManager.totalCorrectAnswers / 3, 5)
                )
                
                AchievementCard(
                    icon: "star.fill",
                    title: loc("perfectionist_title"),
                    description: loc("perfectionist_desc"),
                    color: Color.blue.opacity(0.4),
                    stars: min(achievementManager.fullScoreCount / 4, 5)
                )
                
                Spacer()
            }
            .padding()
        }
    }

    struct AchievementCard: View {
        var icon: String
        var title: String
        var description: String
        var color: Color
        var stars: Int

        var body: some View {
            HStack(alignment: .top) {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .font(.title)
                    .padding()
                    .background(Circle().fill(Color(.systemBackground)))
                    .foregroundColor(.red)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < stars ? "star.fill" : "star")
                                .foregroundColor(index < stars ? .orange : .gray)
                        }
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(color))
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
            .environmentObject(AchievementManager(userId: 0))
            .preferredColorScheme(.dark) // Preview in Dark Mode
    }
}
