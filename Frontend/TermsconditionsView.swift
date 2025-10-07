//
//  TermsconditionsView.swift
//  languageapp
//
//  Created by SAIL on 01/09/25.
//

//
//  TermsConditionsView.swift
//  hometutor
//
//  Created by sails mac on 15/07/25.
//


import SwiftUI

struct TermsConditionsView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top Navigation
            HStack {
                

                Text("Terms & Conditions")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()

                // EN Language Button
                
            }
            .padding()
            .background(Color.clear)

            // Terms Content
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    termSection(
                        title: "Introduction",
                        content: "Welcome to TutorConnect. These Terms & Conditions govern your use of our tutoring platform and services. By accessing or using our application, you agree to be bound by these terms."
                    )

                    termSection(
                        title: "User Responsibilities",
                        content: "Users must maintain accurate profile information, respect intellectual property rights, and adhere to our community guidelines. Tutors must provide professional services and maintain appropriate conduct."
                    )

                    termSection(
                        title: "Privacy Policy Summary",
                        content: "We collect and process personal data as outlined in our Privacy Policy. This includes profile information, usage data, and communication records between tutors and students."
                    )

                    termSection(
                        title: "Account Usage Rules",
                        content: "Accounts are personal and non-transferable. Users must maintain security of their credentials and report any unauthorized access immediately."
                    )

                    termSection(
                        title: "Payments and Refunds",
                        content: "Payment processing is handled securely through authorized providers. Refunds are processed according to our refund policy within specified timeframes."
                    )

                    termSection(
                        title: "Termination",
                        content: "We reserve the right to suspend or terminate accounts for violations of these terms. Users may terminate their accounts at any time through the app settings."
                    )

                    termSection(
                        title: "Dispute Resolution",
                        content: "Disputes will be resolved through our internal resolution process first. Unresolved matters may proceed to mediation or arbitration as specified."
                    )

                    termSection(
                        title: "Governing Law",
                        content: "These terms are governed by California law. Any legal proceedings shall be brought in the courts of California."
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(14)
                .padding()
            }
            .background(Color(red: 243/255, green: 246/255, blue: 251/255)) // Light blue background
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    // MARK: - Reusable Term Section
    private func termSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Text(content)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct TermsConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsConditionsView()
    }
}
