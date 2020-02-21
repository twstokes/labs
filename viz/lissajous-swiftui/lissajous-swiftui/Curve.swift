//
//  Curve.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/1/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI


struct Curve_Previews: PreviewProvider {
    static var previews: some View {
        Curve(a: 3, b: 5)
            .stroke(Color.red)
            .border(Color.red)
    }
}

struct AnimatedCurve: View {
    @State private var animate = false
    @State private var tapped = false
    let a: Double
    let b: Double
    let hue: Double

    var body: some View {
        ZStack {
            Rectangle()
                .fill(tapped ? Color.clear : Color.black)

            Curve(a: self.a, b: self.b)
                .trim(from: self.animate ? 0 : 1, to: 1)
                .stroke(
                    Color.init(
                        hue: hue,
                        saturation: 0.75,
                        brightness: 1
                ), lineWidth: 1)
                .animation(
                    Animation.linear(duration: 8)
                        .repeatForever(autoreverses: true)
                )
                .onAppear() {
                    self.animate.toggle()
                }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.tapped.toggle()
            }
        }
        .scaleEffect(tapped ? 5.0 : 1.0)
        .zIndex(tapped ? 100 : 1)
    }
}

struct Curve: Shape {
    let a: Double
    let b: Double
    let points: [CGPoint]

    init(a: Double, b: Double) {
        self.a = a
        self.b = b

        // this is used to precompute the points to reduce
        // CPU load, since path() is called on trim()
        self.points = Curve.calculatePoints(a: a, b: b)
    }

    static func calculatePoints(a: Double, b: Double) -> [CGPoint] {
        var points = [CGPoint]()

        for i in 0...360 {
            let rad = (.pi / 180) * Double(i)
            let x = sin(a*rad + .pi / 2)
            let y = sin(b * rad)

            points.append(CGPoint(x: x, y: y))
        }

        return points
    }

    func path(in rect: CGRect) -> Path {
        // radius is the length of the smallest side
        let r = min(rect.size.width, rect.size.height) / 2

        var path = Path()
        path.addLines(points)
        path.closeSubpath()

        return path
            .applying(.init(scaleX: r, y: r))
            .applying(.init(
                translationX: rect.size.width / 2,
                y: rect.size.height / 2)
            )
    }
}
