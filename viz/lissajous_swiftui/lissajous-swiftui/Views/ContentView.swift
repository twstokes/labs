//
//  ContentView.swift
//  lissajous-swiftui
//
//  Created by Tanner W. Stokes on 2/1/20.
//  Copyright © 2020 Tanner Stokes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("replace me")
                .tabItem {
                    Image(systemName: "circle")
                }
                                
            GridView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
