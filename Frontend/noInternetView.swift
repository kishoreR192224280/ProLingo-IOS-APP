import SwiftUI

struct noInternetView: View {
    var retryAction: () -> Void = {}
    @State private var isRetrying = false

    var body: some View {
        VStack {
            Spacer()

            Image("cloud")
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 300)
                .foregroundColor(.blue)
                .padding(.bottom, 16)

            Text("No Internet Connection")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text("Oops... You are not connected to the internet.\nPlease try again.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.bottom, 24)

            if isRetrying {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(1.2)
                    .padding()
            } else {
                Button(action: {
                    isRetrying = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        retryAction()
                        isRetrying = false
                    }
                }) {
                    Text("Try Again")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white) // ✅ Solid white background
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    noInternetView {
        print("Retry tapped from preview")
    }
}
