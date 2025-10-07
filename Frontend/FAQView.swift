//
//  FAQView.swift
//  languageapp
//
//  Created by SAIL on 01/09/25.
//

import SwiftUI

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    var isExpanded: Bool = false
}

struct FAQView: View {
    @State private var faqItems: [FAQItem] = [
        FAQItem(question: "How do I book a tutor?", answer: "You can book a tutor by browsing profiles, selecting your preferred time and mode, and confirming the booking."),
        FAQItem(question: "How are tutors verified?", answer: "Tutors go through a strict background check and submit academic documents for verification."),
        FAQItem(question: "Can I reschedule a session?", answer: "Yes, sessions can be rescheduled through your dashboard at least 24 hours in advance."),
        FAQItem(question: "Is there a cancellation fee?", answer: "Cancellations within 24 hours of the session may incur a nominal fee."),
        FAQItem(question: "How do I contact support?", answer: "You can reach out to support via email, phone, or the in-app chat available on the Help & Support page.")
    ]

    var body: some View {
        VStack(spacing: 16) {
            // Top bar with Back button and title
            HStack {
                
                Text("FAQs")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 4)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            // FAQ card
            VStack(spacing: 0) {
                ForEach(faqItems.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 6) {
                        Button(action: {
                            faqItems[index].isExpanded.toggle()
                        }) {
                            HStack {
                                Text(faqItems[index].question)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: faqItems[index].isExpanded ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                            }
                        }
                        if faqItems[index].isExpanded {
                            Text(faqItems[index].answer)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.top, 4)
                        }
                        Divider()
                            .padding(.top, 8)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(red: 243/255, green: 246/255, blue: 251/255)) // Light blue background
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
