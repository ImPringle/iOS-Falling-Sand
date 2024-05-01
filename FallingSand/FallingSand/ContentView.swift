//
//  ContentView.swift
//  FallingSand
//
//  Created by Mario Pringle on 12/04/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: FallingSand1D()) {
                    Text("Falling Sand 1D")
                }
                NavigationLink(destination: FallingSand2D()) {
                    Text("Falling Sand 2D")
                }

            }
            .navigationTitle("Simulator")

        }
        
    }
}

#Preview {
    ContentView()
}
