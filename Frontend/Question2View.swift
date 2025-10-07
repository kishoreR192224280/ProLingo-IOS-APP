import SwiftUI
import AVFoundation

// MARK: - Segmented Progress Bar
struct SegmentedProgressBar: View {
    var totalSegments: Int
    var currentSegment: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalSegments, id: \.self) { index in
                Capsule()
                    .fill(index < currentSegment ?
                          LinearGradient(colors: [Color.blue, Color.blue.opacity(0.7)], startPoint: .leading, endPoint: .trailing) :
                          LinearGradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.2)], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(height: 8)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Main Question View
struct QuestionView: View {
    let level: String

    @StateObject private var questionManager = QuestionManager()
    @EnvironmentObject var appState: AppState

    @State private var currentIndex = 0
    @State private var selectedOptionId: Int? = nil
    @State private var showFeedback = false
    @State private var isCorrect = false
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    @State private var totalCorrect = 0
    @State private var isQuizCompleted = false
    @State private var showLevelCompletedMessage = false

    private let totalQuestionsCount = 20

    var body: some View {
        VStack {
            if questionManager.questions.isEmpty {
                ProgressView("Loading questions...")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
                    .onAppear {
                        loadLevelQuestions()
                    }
            } else if isQuizCompleted {
                completedView()
            } else {
                quizView()
            }
        }
        .navigationTitle("Questions")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Completed View
    @ViewBuilder
    private func completedView() -> some View {
        VStack(spacing: 30) {
            Spacer()
            
            if showLevelCompletedMessage {
                Text("🎉 Congratulations! You completed \(level.capitalized) level! 🎉")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.purple)
                    .padding()
                
                Button(action: moveToNextLevel) {
                    Text("Next Level")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            } else {
                Text("You answered \(totalCorrect) out of \(totalQuestionsCount) questions correctly!")
                    .font(.title3)
                    .foregroundColor(Color.primary)
                
                Button(action: restartQuiz) {
                    Text("Try Again")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }

    // MARK: - Quiz View
    @ViewBuilder
    private func quizView() -> some View {
        let question = questionManager.questions[currentIndex]
        
        ScrollView {
            VStack(spacing: 25) {
                // Header
                HStack {
                    Text("Level: \(question.level.capitalized)")
                        .font(.headline)
                        .foregroundColor(Color.red)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Progress Bar
                SegmentedProgressBar(
                    totalSegments: questionManager.questions.count,
                    currentSegment: currentIndex + 1
                )
                
                // Question or Flashcard
                if question.question_type == "flashcard" {
                    flashcardView(for: question)
                } else {
                    VStack(spacing: 15) {
                        Text(questionText(for: question))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                    .padding(.horizontal)
                }
                
                // Audio Button
                if question.question_type == "audio" {
                    audioButton(text: question.tamil_text)
                }
                
                // Options
                if !question.options.isEmpty {
                    VStack(spacing: 12) {
                        ForEach(question.options) { option in
                            optionSelectableButton(option: option)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Submit Button
                if selectedOptionId != nil && !showFeedback {
                    submitButton()
                }
                
                // Feedback
                if showFeedback {
                    feedbackView(for: question)
                }
                
                Spacer(minLength: 50)
                
                // Navigation Buttons
                HStack(spacing: 15) {
                    previousButton()
                    skipButton()
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }

    // MARK: - Flashcard View (Tamil + English)
    @ViewBuilder
    private func flashcardView(for question: Question) -> some View {
        VStack(spacing: 12) {
            Text(question.tamil_text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Divider().background(Color.gray.opacity(0.5))
            
            Text(question.english_text)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
    }

    // MARK: - Question Text
    private func questionText(for question: Question) -> String {
        switch question.question_type {
        case "quiz", "audio":
            return question.tamil_text
        default:
            return question.english_text
        }
    }

    // MARK: - Buttons
    private func audioButton(text: String) -> some View {
        Button(action: { speak(text: text) }) {
            HStack {
                Image(systemName: "play.circle.fill")
                    .font(.title2)
                Text("Play Audio")
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [Color.red, Color.red.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: Color.red.opacity(0.4), radius: 4, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
    
    private func submitButton() -> some View {
        Button(action: submitAnswer) {
            Text("Submit")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(LinearGradient(colors: [Color.red, Color.red.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 4)
        }
        .padding(.horizontal)
    }
    
    private func previousButton() -> some View {
        Button(action: previousQuestion) {
            Text("Previous")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
        .disabled(showFeedback || currentIndex == 0)
    }
    
    private func skipButton() -> some View {
        Button(action: skipQuestion) {
            Text("Skip")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.black.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
        .disabled(showFeedback)
    }

    // MARK: - Question Logic
    private func submitAnswer() {
        guard let selectedId = selectedOptionId else { return }
        isCorrect = questionManager.questions[currentIndex].options.first(where: { $0.id == selectedId })?.is_correct ?? false
        if isCorrect { totalCorrect += 1 }
        withAnimation { showFeedback = true }
    }
    
    private func nextQuestion() {
        selectedOptionId = nil
        showFeedback = false
        isCorrect = false
        
        if currentIndex + 1 >= questionManager.questions.count {
            isQuizCompleted = true
            saveResults()
            if level == "beginner" {
                showLevelCompletedMessage = true
            }
        } else {
            currentIndex += 1
        }
    }
    
    private func previousQuestion() {
        if currentIndex > 0 {
            selectedOptionId = nil
            showFeedback = false
            isCorrect = false
            currentIndex -= 1
        }
    }
    
    private func skipQuestion() {
        selectedOptionId = nil
        showFeedback = false
        isCorrect = false
        if currentIndex + 1 >= questionManager.questions.count {
            isQuizCompleted = true
            saveResults()
        } else {
            currentIndex += 1
        }
    }
    
    private func restartQuiz() {
        currentIndex = 0
        totalCorrect = 0
        isQuizCompleted = false
        selectedOptionId = nil
        showFeedback = false
        loadLevelQuestions()
    }
    
    private func moveToNextLevel() {
        appState.currentLevel = "intermediate"
        restartQuiz()
    }
    
    private func loadLevelQuestions() {
        questionManager.fetchQuestions(level: level)
    }
    
    private func saveResults() {
        questionManager.saveResults(
            userId: String(appState.userId),
            level: level,
            totalCorrect: totalCorrect,
            totalQuestions: totalQuestionsCount
        )
    }

    // MARK: - Audio Functions
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Audio session error: \(error.localizedDescription)")
        }
    }
    
    private func speak(text: String) {
        setupAudioSession()
        if speechSynthesizer.isSpeaking { speechSynthesizer.stopSpeaking(at: .immediate) }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ta-IN") ?? AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }

    // MARK: - Option Button
    @ViewBuilder
    private func optionSelectableButton(option: Option) -> some View {
        let isSelected = selectedOptionId == option.id
        let isAnswer = option.is_correct
        let showAsCorrect = showFeedback && isAnswer
        let showAsWrong = showFeedback && isSelected && !isAnswer
        
        Button(action: {
            if !showFeedback {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                    selectedOptionId = option.id
                }
            }
        }) {
            Text(option.option_text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 55)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(showAsCorrect ? Color.green :
                              showAsWrong ? Color.red :
                              Color.blue)
                )
                .scaleEffect(isSelected && !showFeedback ? 0.95 : 1.0)
                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isSelected)
        }
        .disabled(showFeedback)
    }

    // MARK: - Feedback View
    @ViewBuilder
    private func feedbackView(for question: Question) -> some View {
        VStack(spacing: 12) {
            Text(isCorrect ? "Amazing!" : "Oops.. that's wrong")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(isCorrect ? .green : .red)
            
            HStack {
                Text("Answer:")
                    .fontWeight(.bold)
                    .foregroundColor(isCorrect ? .green : .red)
                Text(question.options.first(where: { $0.is_correct })?.option_text ?? "N/A")
                    .foregroundColor(.primary)
            }
            Spacer()
            
            Button(action: nextQuestion) {
                Text("Next Question")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(isCorrect ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background((isCorrect ? Color.green.opacity(0.15) : Color.red.opacity(0.15)))
        .cornerRadius(12)
        .padding(.horizontal)
        .transition(.opacity)
    }
}

// MARK: - Preview
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuestionView(level: "beginner")
                .environmentObject(AppState())
        }
    }
}
