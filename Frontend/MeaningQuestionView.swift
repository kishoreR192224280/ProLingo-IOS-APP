import SwiftUI
import AVFoundation

struct MeaningQuestionView: View {
    @State private var userAnswer: String = ""
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            // Top Bar with back button and progress indicator
            HStack {
                Button(action: {
                    // handle back
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding()
                        .background(Color.white)
                        .clipShape(Rectangle())
                        .cornerRadius(6)
                        .shadow(radius: 2)
                }
                Spacer()
                HStack(spacing: 6) {
                    ForEach(0..<5) { index in
                        Capsule()
                            .fill(index <= 2 ? Color.blue : Color.gray.opacity(0.3))
                            .frame(width: 20, height: 6)
                    }
                }
                Spacer().frame(width: 44) // same width as back button for symmetry
            }
            .padding(.horizontal)

            // Question prompt
            Text("What’s the meaning of this sentence?")
                .font(.title3.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Audio with text
            HStack(spacing: 12) {
                Button(action: {
                    isPlaying.toggle()
                    // Your audio playback logic here
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Text("Punten, Nami abdi Asep")
                    .font(.body)
                    .foregroundColor(.black)
            }

            // Answer input field
            TextEditor(text: $userAnswer)
                .frame(height: 100)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3))
                )
                .padding(.horizontal)

            // Submit button
            Button(action: {
                // Check answer logic
            }) {
                Text("Check Answer")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(24)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 40)
    }
}

struct MeaningQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        MeaningQuestionView()
    }
}
