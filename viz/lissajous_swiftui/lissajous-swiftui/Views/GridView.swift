//
//  GridView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/21/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct GridView: View {
    private let maxCurves: Double = 10
    @State private var curves: Double = 1
    private var resolution: Double {
        if curves > 5 {
            return 2
        }

        return 1
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    RowView(
                        range: 0 ... Int(self.curves),
                        resolution: resolution
                    )
                }

                HStack {
                    VStack {
                        RowView(
                            range: 1 ... Int(self.curves),
                            resolution: resolution
                        )
                    }

                    ForEach(1 ... Int(self.curves), id: \.self) { i in
                        VStack {
                            RowView(
                                range: 1 ... Int(self.curves),
                                b: i,
                                resolution: resolution
                            )
                        }
                    }
                }
            }
            .padding()
            .aspectRatio(contentMode: .fit)
            .drawingGroup()

            Slider(value: $curves.animation(.spring()), in: 1...maxCurves, step: 1)
                .padding()
                .accentColor(.purple)
        }
    }
}

struct RowView: View {
    let range: ClosedRange<Int>
    var b: Int?
    let resolution: Double

    var body: some View {
        ForEach(range, id: \.self) { i in
            AnimatedCurveView(
                a: i,
                b: self.b ?? i,
                res: self.resolution
            )
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
