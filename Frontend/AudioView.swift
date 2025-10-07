//
//  AudioView.swift
//  languageapp
//
//  Created by SAIL on 14/08/25.
//

import SwiftUI
import AVFoundation

struct AudioView: View {
    @State private var userAnswer = ""
    @State private var showFeedback = true
    @State private var isCorrect = true
    
    let question = "Pronounce the word"
    let correctAnswer = "The correct pronuncation"
    let translatedAnswer = "Permisi, nama saya Asep"
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Back button + Progress
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Capsule()
                            .fill(index < 4 ? Color.blue : Color.gray.opacity(0.3))
                            .frame(width: 30, height: 6)
                    }
                }
                Spacer().frame(width: 44) // space for symmetry
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
            // Question title
            Text("What’s the meaning of this sentence?")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Audio button + Sentence
            HStack(spacing: 12) {
                Button(action: {
                    playAudio(for: question) // will pronounce only the question text
                }) {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.white)
                        .padding(16)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Text(question)
                    .font(.body)
                    .foregroundColor(.black)
            }

            // Answer field with check mark
            ZStack(alignment: .bottomTrailing) {
                TextField("Type your answer...", text: $userAnswer)
                    .padding()
                    .frame(height: 120)
                    .background(Color.gray.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                if isCorrect {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .padding(12)
                }
            }
            
            // Feedback box
            if showFeedback {
                VStack(alignment: .leading, spacing: 6) {
                    Text("That’s right!")
                        .font(.headline)
                        .foregroundColor(Color.green)
                        .bold()
                    
                    Text("Answer :")
                        .foregroundColor(Color.green)
                        .font(.subheadline)
                    
                    Text(translatedAnswer)
                        .foregroundColor(Color.green)
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Next button
            Button(action: {}) {
                Text("Next Question")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(30)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
    }
    

    func playAudio(for text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Change language if needed
        utterance.rate = 0.45 // Adjust speaking speed
        utterance.pitchMultiplier = 1.0 // Adjust pitch
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
#Preview{
    AudioView()
}
