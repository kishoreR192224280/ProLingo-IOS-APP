import SwiftUI

struct DescriptionView: View {
    @EnvironmentObject var achievementManager: AchievementManager
    @EnvironmentObject var appState: AppState
    
    @StateObject private var maxIdFetcher = MaxIdFetcher(appState: AppState())
    @StateObject private var idiomsFetcher = IdiomsFetcher()
    
    @State private var navigateToLearn = false
    let targetHours: Double = 10.0
    
    private func loc(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
    
    var body: some View {
        NavigationStack {
            let hoursProgress = min(achievementManager.totalLearnedHours / targetHours, 1.0)
            let achievementsProgress = Double(achievementManager.achievementsCompleted) / 5.0
            let overallProgress = (hoursProgress + achievementsProgress) / 2.0
            
            VStack(spacing: 10) {
                // Top Image Section
                ZStack(alignment: .topLeading) {
                    Image("chinatown")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Spacer().frame(height: 250)
                        Text(loc("business_language"))
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.white)
                        Text(loc("progress_message"))
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Stats Row with reduced sizes
                HStack(spacing: 30) {
                    VStack {
                        ZStack {
                            Image("people1")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Image("people2")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text("\(appState.maxId)")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    Divider()
                        .frame(height: 40)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 3)
                                .frame(width: 40, height: 40)
                            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(overallProgress))
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .frame(width: 40, height: 40)
                                .animation(.easeOut(duration: 0.6), value: overallProgress)
                            
                            Text("\(Int(overallProgress * 100))%")
                                .font(.caption2)
                                .foregroundColor(.primary)
                        }
                        Text(loc("progress"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                        .frame(height: 40)
                    
                    VStack {
                        ZStack {
                            Image("heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Image("heart1")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text(loc("favorites"))
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                
                // Idioms Section
                Text("Idioms to Learn Today")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if !idiomsFetcher.idioms.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(idiomsFetcher.idioms) { idiom in
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("PHRASE :-").bold()
                                    Text(idiom.phrase)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    
                                    Text("MEANING OF THE SENTENCE :-").bold()
                                    Text(idiom.usage_context)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    
                                    Text("EXAMPLE FOR USAGE :-").bold()
                                    Text(idiom.example)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                Divider()
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    .padding(.horizontal, 20)
                } else if !idiomsFetcher.errorMessage.isEmpty {
                    Text("Error: \(idiomsFetcher.errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Loading idioms...")
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                // Learn Button
                Button(action: {
                    navigateToLearn = true
                }) {
                    HStack {
                        Text(loc("learn_language"))
                            .bold()
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.top)
            .navigationDestination(isPresented: $navigateToLearn) {
                LearningpageView()
            }
            .onAppear {
                maxIdFetcher.appState = appState
                maxIdFetcher.fetchMaxId()
                idiomsFetcher.fetchIdioms()
            }
        }
    }
}

#Preview {
    DescriptionView()
        .environmentObject(AchievementManager(userId: 1))
        .environmentObject(AppState())
        .preferredColorScheme(.light)
}
