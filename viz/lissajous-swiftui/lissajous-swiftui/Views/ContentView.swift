//
//  ContentView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/1/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().backgroundColor = .black
    }

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            TabView {
                Text("replace me")
                    .tabItem {
                        Image(systemName: "circle")
                }

                    GridView()
                        .background(Color.black)
                        .tabItem {
                            Image(systemName: "circle.grid.3x3")
                            // todo - add gradient mask to tab button
    //                        .mask(
    //                            Gradient(colors: [Color.red, Color.blue])
    //                        )
                }
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
