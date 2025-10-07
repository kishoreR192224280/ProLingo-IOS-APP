//
//  helpSupportView.swift
//  languageapp
//
//  Created by SAIL on 01/09/25.
//


import SwiftUI

struct HelpSupportView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Header with back button
                HStack {
                    
                    Spacer()

                    Text("Help & Support")
                        .font(.headline)
                        .foregroundColor(.black)

                    Spacer()

                    Spacer().frame(width: 32) // To balance spacing
                }
                .padding(.horizontal)
                .padding(.top, 20)

                // Support Card
                VStack(spacing: 0) {
                    supportRow(icon: "doc.text.fill", title: "Frequently Asked Questions", subtitle: "Find quick answers", destination: FAQView())
                    Divider()
                    supportRow(icon: "envelope.fill", title: "Email Support", subtitle: "support@tutorapp.com", destination: SupportDetailView(title: "Email Support"))
                    Divider()
                    supportRow(icon: "phone.fill", title: "Call Us", subtitle: "+91 98765 43210", destination: SupportDetailView(title: "Call Support"))
                    Divider()
                    supportRow(icon: "exclamationmark.bubble.fill", title: "Report an Issue", subtitle: "Let us know what’s wrong", destination: ReportIssueView())
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)

                Spacer()

                Text("Need help? Our support team is here for you.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }
            .background(Color(red: 0.95, green: 0.96, blue: 0.98))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }

    // MARK: - Reusable Support Row
    @ViewBuilder
    func supportRow<Destination: View>(icon: String, title: String, subtitle: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .frame(width: 30)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Dummy Support Detail View
struct SupportDetailView: View {
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle(title)
    }
}

#Preview {
    HelpSupportView()
}
