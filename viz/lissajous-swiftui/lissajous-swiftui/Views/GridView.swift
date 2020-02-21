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
    let maxCurves = 8

    var body: some View {
        ZStack {
            Color.black

            VStack {
                HStack {
                    ForEach(0 ... self.maxCurves, id: \.self) { i in
                        AnimatedCurveView(a: i, b: i, animate: self.animate)
                    }
                }

                HStack {
                    VStack {
                        ForEach(1 ... self.maxCurves, id: \.self) { i in
                            AnimatedCurveView(a: i, b: i, animate: self.animate)
                        }
                    }

                    ForEach(1 ... self.maxCurves, id: \.self) { i in
                        VStack {
                            ForEach(1 ... self.maxCurves, id: \.self) { j in
                                AnimatedCurveView(a: i, b: j, animate: self.animate)
                            }
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
        }.edgesIgnoringSafeArea(.all)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
