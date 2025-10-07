//
//  registerview.swift
//  languageapp
//
//  Created by SAIL on 27/05/25.
//

import SwiftUI

struct CreateProfileView: View {
    @State private var profileNav = false
    @State private var backNav = false
    var body: some View {
        
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    
                    // Red top with illustration
                    ZStack {
                        Image("ellipse")
                            .resizable()
                            .frame(width: 450,height:450)
                            .scaledToFit()
                        Image("registerback")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 350)
                    }
                    // Content
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Create Your Profile ")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                            .fontWeight(.semibold)
                        + Text("Now!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        
                        Text("Create a profile to save your learning progress and keep learning for free!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    
                    // Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            backNav = true
                            // Back action
                        }) {
                            Text("Back")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            profileNav = true
                            // Next action
                        }) {
                            Text("Next")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                    
                }
                
                .edgesIgnoringSafeArea(.top)
                .navigationBarBackButtonHidden(true) // hides back button
                       .navigationBarHidden(true)
                .navigationDestination(isPresented: $profileNav) {
                    NameView()
                }
                .navigationDestination(isPresented: $backNav){
                    LOGREGView()
                }
            }
        }
    }
    
    
    
    // Custom shape for the bottom curve of the red section
    
struct CreateProfileView_Previews: PreviewProvider {
   static var previews: some View {
        CreateProfileView()
    }
}

