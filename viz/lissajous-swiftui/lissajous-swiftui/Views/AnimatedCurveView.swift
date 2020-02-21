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
    var animate = false

    var body: some View {
        Curve(a: a, b: b)
            .trim(from: self.animate ? 0 : 1, to: 1)
            .stroke(
                Color.init(
                    hue: b == 0 ? 0 : Double(a/b) / Double((a+b)),
                    saturation: 0.75,
                    brightness: 1
            ), lineWidth: 1)
            .animation(
                Animation.linear(duration: 8)
                    .repeatForever(autoreverses: true)
            )
            // really important for grid layout
            .aspectRatio(contentMode: .fit)
    }
}

struct AnimatedCurveView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCurveView(a: 1, b: 2, animate: true)
    }
}
