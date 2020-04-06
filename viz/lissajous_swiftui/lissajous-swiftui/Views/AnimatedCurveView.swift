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
    var res = 1.0
    var animate = false

    var body: some View {
        Curve(a: a, b: b, res: res)
            .trim(from: self.animate ? 0 : 1, to: 1)
            .stroke(
                Color.init(
                    hue: b == 0 ? 0 : Double(a) / Double((a+b)),
                    saturation: 0.75,
                    brightness: 1
            ), lineWidth: 1)
            .background(Color.black) // so the curve is clickable
            .aspectRatio(contentMode: .fit) // really important for grid layout
            .animation(
                Animation.linear(duration: 8)
                    .repeatForever(autoreverses: true)
            )
            .onTapGesture {
                print("Curve \(self.a) \(self.b) tapped")
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
            AnimatedCurveView(a: 3, b: 5, animate: animate)
                .onAppear {
                    self.animate = true
                }
        }
    }
}
