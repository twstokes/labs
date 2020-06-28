//
//  AnimatedCurveView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/21/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct AnimatedCurveView: View {
    let a: Int
    let b: Int
    var res: Double
    @State private var animate = false

    private let curve: LJCurve

    init(a: Int, b: Int, res: Double = 1.0) {
        self.a = a
        self.b = b
        self.res = res

        curve = LJCurve(a: a, b: b, res: res)
    }

    private let animation = Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)

    var body: some View {
        curve
            .trim(from: self.animate ? 0 : 1, to: 1)
            .stroke(
                Color(
                    hue: b == 0 ? 0 : Double(a) / Double((a+b)),
                    saturation: 0.75,
                    brightness: 1
            ), lineWidth: 2)
            .background(Color.black) // so the curve is clickable
            .scaledToFit()
            .onTapGesture {
                print("Curve \(self.a) \(self.b) tapped")
            }
            .onAppear {
                withAnimation(animation) {
                    self.animate = true
                }
            }
    }
}

struct AnimatedCurveView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    // by having a preview wrapper, we can
    // include state to kick off the animation
    struct PreviewWrapper: View {
        @State var animate = false

        var body: some View {
            AnimatedCurveView(a: 3, b: 5)
                .onAppear {
                    self.animate = true
                }
        }
    }
}
