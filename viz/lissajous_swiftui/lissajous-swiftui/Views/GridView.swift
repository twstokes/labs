//
//  GridView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/21/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct GridView: View {
    @State var animate = false
    let maxCurves = 4
    let resolution = 2.0

    var body: some View {
        ZStack {
            Color.black

            VStack {
                HStack {
                    RowView(
                        range: 0 ... self.maxCurves,
                        resolution: self.resolution,
                        animate: self.animate
                    )
                }

                HStack {
                    VStack {
                        RowView(
                            range: 1 ... self.maxCurves,
                            resolution: self.resolution,
                            animate: self.animate
                        )
                    }

                    ForEach(1 ... self.maxCurves, id: \.self) { i in
                        VStack {
                            RowView(
                                range: 1 ... self.maxCurves,
                                b: i,
                                resolution: self.resolution,
                                animate: self.animate
                            )
                        }
                    }
                }
            }
            .padding()
            .onAppear() {
                self.animate = true
            }
            .onDisappear() {
                self.animate = false
            }
        }
    }
}

struct RowView: View {
    let range: ClosedRange<Int>
    var b: Int?
    let resolution: Double
    let animate: Bool

    var body: some View {
        ForEach(range, id: \.self) { i in
            AnimatedCurveView(
                a: i,
                b: self.b ?? i,
                res: self.resolution,
                animate: self.animate
            )
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
