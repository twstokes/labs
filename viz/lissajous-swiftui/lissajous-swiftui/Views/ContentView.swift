//
//  ContentView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/1/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var a = 1.0
    @State private var b = 1.0

    let maxCurves = 8

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)

            VStack(alignment: .center) {
                AnimatedCurve(a: Double(1), b: Double(9), hue: 0)
//                AnimatedCurve(a: Double(2), b: Double(8), hue: 0)
//                AnimatedCurve(a: Double(3), b: Double(7), hue: 0)
//                AnimatedCurve(a: Double(4), b: Double(6), hue: 0)
//                AnimatedCurve(a: Double(5), b: Double(5), hue: 0)
//                AnimatedCurve(a: Double(6), b: Double(4), hue: 0)
//                AnimatedCurve(a: Double(7), b: Double(3), hue: 0)
//                AnimatedCurve(a: Double(8), b: Double(2), hue: 0)
//                AnimatedCurve(a: Double(9), b: Double(1), hue: 0)
//                HStack {
//                    AnimatedCurve(a: Double(0), b: Double(0), hue: 0)
//                    ForEach(1 ... self.maxCurves, id: \.self) { i in
//                        AnimatedCurve(a: Double(i), b: Double(i), hue: Double(i) / Double(self.maxCurves))
//                    }
//                }.frame(height: 40)

//                HStack {
//                    VStack {
//                        ForEach(1 ... self.maxCurves, id: \.self) { i in
//                            AnimatedCurve(a: Double(i), b: Double(i), hue: Double(i) / Double(self.maxCurves))
//                        }
//                    }
//
//                    ForEach(1 ... self.maxCurves, id: \.self) { i in
//                        VStack {
//                            ForEach(1 ... self.maxCurves, id: \.self) { j in
//                                AnimatedCurve(a: Double(i), b: Double(j), hue: Double(i) / Double(self.maxCurves))
//                            }
//                        }
//                    }
//                }
            }
            .padding()
            .frame(height: 500)
//            .drawingGroup()
        }
//        .drawingGroup()
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
