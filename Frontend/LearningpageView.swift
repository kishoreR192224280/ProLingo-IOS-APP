import SwiftUI

// MARK: - Main Learning Page View
struct LearningpageView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var selectedLevel: String? = nil
    
    let courses = [
        Course(level: "beginner", title: "Introduction", duration: "1 Hour 30 Minute", progress: 9, total: 50, color: Color.green, imageName: "level1"),
        Course(level: "intermediate", title: "Grammar", duration: "1 Hour 45 Minute", progress: 5, total: 40, color: Color.orange, imageName: "level2"),
        Course(level: "advanced", title: "Vocabulary", duration: "1 Hour 2 Minute", progress: 2, total: 50, color: Color.red, imageName: "level3")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 20)
                
                Image("people")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)
                
                Text("Learn Business English")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(appState.isDarkMode ? .white : .black)
                    .padding(.bottom, 20)
                
                VStack(spacing: 16) {
                    ForEach(courses, id: \.level) { course in
                        Button(action: {
                            selectedLevel = course.level
                        }) {
                            CourseCardView(course: course, isDarkMode: appState.isDarkMode)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Navigation Links
                NavigationLink(
                    destination: QuestionView(level: selectedLevel ?? "beginner"),
                    tag: "beginner",
                    selection: $selectedLevel
                ) { EmptyView() }
                
                NavigationLink(
                    destination: QuestionView(level: selectedLevel ?? "intermediate"),
                    tag: "intermediate",
                    selection: $selectedLevel
                ) { EmptyView() }
                
                NavigationLink(
                    destination: QuestionView(level: selectedLevel ?? "advanced"),
                    tag: "advanced",
                    selection: $selectedLevel
                ) { EmptyView() }
            }
            .background(appState.isDarkMode ? Color.black : Color.white)
        }
    }
}

// MARK: - Course Model
struct Course {
    let level: String
    let title: String
    let duration: String
    let progress: Int
    let total: Int
    let color: Color
    let imageName: String
}

// MARK: - Course Card View
struct CourseCardView: View {
    let course: Course
    let isDarkMode: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(course.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.headline)
                    .foregroundColor(isDarkMode ? .white : .black)
                
                HStack {
                    Text(course.level.capitalized)
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(course.color)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    Text(course.duration)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .frame(height: 8)
                                .foregroundColor(Color.gray.opacity(0.2))
                            
                            Capsule()
                                .frame(width: geometry.size.width * CGFloat(course.progress) / CGFloat(course.total), height: 8)
                                .foregroundColor(course.color)
                        }
                    }
                    .frame(height: 8)
                    
                    Text("\(course.progress)/\(course.total)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 50, alignment: .trailing)
                }
            }
        }
        .padding()
        .background(isDarkMode ? Color(.systemGray6) : Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview
struct LearningpageView_Previews: PreviewProvider {
    static var previews: some View {
        LearningpageView()
            .environmentObject(AppState())
    }
}
