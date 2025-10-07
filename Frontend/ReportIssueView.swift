//
//  ReportIssueView.swift
//  languageapp
//
//  Created by SAIL on 01/09/25.
//

import SwiftUI

struct ReportIssueView: View {
    @Environment(\.dismiss) var dismiss
    @State private var issueDescription: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Top Bar
            HStack {
                

                Spacer()
                Text("Report an Issue")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                
                // Spacer to balance the back button
                Spacer().frame(width: 24)
            }
            .padding(.horizontal)
            .padding(.top)

            // Description Label and TextEditor
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.subheadline)
                    .foregroundColor(.black)

                ZStack(alignment: .topLeading) {
                    if issueDescription.isEmpty {
                        Text("Describe the issue in detail...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.horizontal, 5)
                        
                    }

                    TextEditor(text: $issueDescription)
                        .frame(height: 120)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Submit and Cancel Buttons
            VStack(spacing: 12) {
                Button(action: {
                    // Handle Submit Report
                }) {
                    Text("Submit Report")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// MARK: - Preview
struct ReportIssueView_Previews: PreviewProvider {
    static var previews: some View {
        ReportIssueView()
    }
}
