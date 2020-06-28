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
        LJCurve(a: 3, b: 5)
            .stroke(Color.red)
            .border(Color.red)
    }
}

struct LJCurve: Shape {
    private let path: Path

    init(a: Int, b: Int, res: Double = 1.0) {
        let points = LJCurve.calculatePoints(a: a, b: b, res: res)

        var path = Path()
        path.addLines(points)
        path.closeSubpath()

        self.path = path
    }

    static func calculatePoints(a: Int, b: Int, res: Double) -> [CGPoint] {
        var points = [CGPoint]()

        // a higher number for resolution increases performance
        // by decreasing points
        for i in stride(from: 0, to: 360, by: res) {
            let rad = (.pi / 180) * Double(i)
            let x = sin(Double(a)*rad + Double.pi / 2)
            let y = sin(Double(b) * rad)

            points.append(CGPoint(x: x, y: y))
        }

        return points
    }

    func path(in rect: CGRect) -> Path {
        // radius is the length of the smallest side
        let r = min(rect.size.width, rect.size.height) / 2

        return path
            .applying(.init(scaleX: r, y: r))
            .applying(.init(
                translationX: rect.size.width / 2,
                y: rect.size.height / 2)
        )
    }
}
