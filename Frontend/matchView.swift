import SwiftUI
import AVFoundation

struct MatchSoundView: View {
    // Dummy data
    let phrases = Array(repeating: "Abdi ujang, nami anjeun saha?", count: 4)
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Match the\npronouncation Sound")
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
            
            ForEach(phrases.indices, id: \.self) { index in
                HStack(spacing: 20) {
                    Button(action: {
                        // Add sound playback action here
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(radius: 4)
                    }
                    
                    Text(phrases[index])
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                // Handle answer submission
            }) {
                Text("Submit Answer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}
#Preview{
    MatchSoundView()
}
