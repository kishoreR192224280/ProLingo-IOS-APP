//
//  contentview.swift
//  languageapp
//
//  Created by SAIL on 26/05/25.
//

import SwiftUI

struct splashView: View {
    @State private var animate = false
    @State private var navigateToNext = false

    var body: some View {
        if navigateToNext {
            LOGREGView() // <-- Navigate here after delay
        } else {
            ZStack {
                // Background
                Image("splash")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                ZStack {
                    Image("logo border")
                        .resizable()
                        .frame(width: 159.01, height: 164.01)
                        .padding(.top, -300)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.8)
                        .animation(.easeOut(duration: 1), value: animate)

                    MyShape()
                        .foregroundColor(.black)
                        .frame(width: 121.12, height: 127.67)
                        .padding(.top, -282)
                        .opacity(animate ? 1 : 0)
                        .animation(.easeOut(duration: 1.2), value: animate)

                    Image("logo V")
                        .resizable()
                        .frame(width: 74, height: 80)
                        .padding(.top, -259)
                        .opacity(animate ? 1 : 0)
                        .animation(.easeOut(duration: 1.4), value: animate)
                }
            }
            .onAppear {
                animate = true

                // Navigate after 2.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    navigateToNext = true
                }
            }
        }
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.4109*width, y: 0.02187*height))
        path.addCurve(to: CGPoint(x: 0.58186*width, y: 0.02187*height), control1: CGPoint(x: 0.4641*width, y: -0.00614*height), control2: CGPoint(x: 0.52866*width, y: -0.00614*height))
        path.addLine(to: CGPoint(x: 0.90138*width, y: 0.1901*height))
        path.addCurve(to: CGPoint(x: 0.99276*width, y: 0.33778*height), control1: CGPoint(x: 0.95775*width, y: 0.21979*height), control2: CGPoint(x: 0.99276*width, y: 0.27636*height))
        path.addLine(to: CGPoint(x: 0.99276*width, y: 0.66137*height))
        path.addCurve(to: CGPoint(x: 0.90138*width, y: 0.80905*height), control1: CGPoint(x: 0.99276*width, y: 0.7228*height), control2: CGPoint(x: 0.95775*width, y: 0.77936*height))
        path.addLine(to: CGPoint(x: 0.58186*width, y: 0.97728*height))
        path.addCurve(to: CGPoint(x: 0.4109*width, y: 0.97728*height), control1: CGPoint(x: 0.52866*width, y: 1.0053*height), control2: CGPoint(x: 0.4641*width, y: 1.0053*height))
        path.addLine(to: CGPoint(x: 0.09139*width, y: 0.80905*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.66137*height), control1: CGPoint(x: 0.03501*width, y: 0.77936*height), control2: CGPoint(x: 0, y: 0.7228*height))
        path.addLine(to: CGPoint(x: 0, y: 0.33778*height))
        path.addCurve(to: CGPoint(x: 0.09139*width, y: 0.1901*height), control1: CGPoint(x: 0, y: 0.27636*height), control2: CGPoint(x: 0.03501*width, y: 0.21979*height))
        path.addLine(to: CGPoint(x: 0.4109*width, y: 0.02187*height))
        path.closeSubpath()
        return path
    }
}
struct mycircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.41631*width, y: 0.02643*height))
        path.addCurve(to: CGPoint(x: 0.57705*width, y: 0.02397*height), control1: CGPoint(x: 0.46623*width, y: 0.00017*height), control2: CGPoint(x: 0.52649*width, y: -0.00066*height))
        path.addLine(to: CGPoint(x: 0.58192*width, y: 0.02643*height))
        path.addLine(to: CGPoint(x: 0.90253*width, y: 0.19511*height))
        path.addCurve(to: CGPoint(x: 0.99094*width, y: 0.33781*height), control1: CGPoint(x: 0.95712*width, y: 0.22384*height), control2: CGPoint(x: 0.99094*width, y: 0.27852*height))
        path.addLine(to: CGPoint(x: 0.99094*width, y: 0.66225*height))
        path.addCurve(to: CGPoint(x: 0.90507*width, y: 0.80359*height), control1: CGPoint(x: 0.99094*width, y: 0.72062*height), control2: CGPoint(x: 0.95817*width, y: 0.77452*height))
        path.addLine(to: CGPoint(x: 0.90253*width, y: 0.80496*height))
        path.addLine(to: CGPoint(x: 0.58192*width, y: 0.97363*height))
        path.addCurve(to: CGPoint(x: 0.42118*width, y: 0.97609*height), control1: CGPoint(x: 0.532*width, y: 0.99989*height), control2: CGPoint(x: 0.47174*width, y: 1.00071*height))
        path.addLine(to: CGPoint(x: 0.41631*width, y: 0.97363*height))
        path.addLine(to: CGPoint(x: 0.09571*width, y: 0.80496*height))
        path.addCurve(to: CGPoint(x: 0.00729*width, y: 0.66225*height), control1: CGPoint(x: 0.04111*width, y: 0.77623*height), control2: CGPoint(x: 0.00729*width, y: 0.72154*height))
        path.addLine(to: CGPoint(x: 0.00729*width, y: 0.33781*height))
        path.addLine(to: CGPoint(x: 0.00732*width, y: 0.33503*height))
        path.addCurve(to: CGPoint(x: 0.09316*width, y: 0.19647*height), control1: CGPoint(x: 0.00834*width, y: 0.27774*height), control2: CGPoint(x: 0.0409*width, y: 0.22508*height))
        path.addLine(to: CGPoint(x: 0.09571*width, y: 0.19511*height))
        path.addLine(to: CGPoint(x: 0.41631*width, y: 0.02643*height))
        path.closeSubpath()
        return path
    }
}

struct splashView_Previews: PreviewProvider {
    static var previews: some View {
        splashView()
    }
}
