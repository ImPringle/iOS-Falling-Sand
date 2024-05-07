//
//  FallingSandView.swift
//  macOS-falling-sand
//
//  Created by Mario Pringle on 06/05/24.
//

import SwiftUI

struct GameOfLifeView: View {
    @State var actual = [[Int]](repeating: [Int](repeating: 0, count: 15), count: 30)
    @State var next = [[Int]](repeating: [Int](repeating: 0, count: 15), count: 30)
    @State var isChanged: Bool = false
    
    @State private var frameCounter: Int = 0
    
    func setupGame () {
        for i in 0...(actual.count - 1) {
            for j in 0...(actual[0].count - 1) {
                actual[i][j] = Int.random(in: 0...1)
            }
        }
    }
    
    
    func getNeighbors(i: Int, j: Int) -> Int {
//        checking if the cell is in a corner
        if (i == 0 && j == 0) {
            return actual[i+1][j] + actual[i+1][j+1] + actual[i][j+1]
        } else if (i == 0 && j == actual[0].count - 1) {
            return actual[i][j-1] + actual[i+1][j-1] + actual[i+1][j]
        } else if (i == actual.count - 1 && j == 0) {
            return actual[i-1][j] + actual[i-1][j+1] + actual[i][j+1]
        } else if (i == actual.count - 1 && j == actual[0].count - 1){
            return actual[i][j-1] + actual[i-1][j-1] + actual[i-1][j]
        }
//        checking if the cell is in a border
        else if (i == 0) {
            return actual[i][j-1] + actual[i+1][j-1] + actual[i+1][j] + actual[i+1][j+1] + actual[i][j+1]
        } else if (j == 0) {
            return actual[i-1][j] + actual[i-1][j+1] + actual[i][j+1] + actual[i+1][j+1] + actual[i+1][j]
        } else if (i == actual.count - 1) {
            return actual[i][j-1] + actual[i-1][j-1] + actual[i-1][j] + actual[i-1][j+1] + actual[i][j+1]
        } else if (j == actual[0].count - 1) {
            return actual[i-1][j] + actual[i-1][j-1] + actual[i][j-1] + actual[i+1][j-1] + actual[i+1][j]
        } else {
            return actual[i-1][j-1] + actual[i-1][j] + actual[i-1][j+1] + actual[i][j-1] + actual[i][j+1] + actual[i+1][j-1] + actual[i+1][j] + actual[i+1][j+1]
        }
    }
    
    func testPoints () {
//        corners
        actual[0][1] = 1
        actual[1][1] = 1
        actual[1][0] = 1
        
        actual[0][actual[0].count - 2] = 1
        actual[1][actual[0].count - 2] = 1
        actual[1][actual[0].count - 1] = 1
        
        actual[actual.count - 2][0] = 1
        actual[actual.count - 2][1] = 1
        actual[actual.count - 1][1] = 1
        
        actual[actual.count - 2][actual[0].count - 2] = 1
        actual[actual.count - 1][actual[0].count - 2] = 1
        actual[actual.count - 2][actual[0].count - 1] = 1
        
//        borders
        actual[actual.count/2][actual[0].count - 2] = 1
        actual[(actual.count/2) + 1][actual[0].count - 2] = 1
        actual[(actual.count/2) - 1][actual[0].count - 2] = 1
        actual[(actual.count/2) + 1][actual[0].count - 1] = 1
        actual[(actual.count/2) - 1][actual[0].count - 1] = 1
        
        actual[actual.count/2][1] = 1
        actual[(actual.count/2) + 1][0] = 1
        actual[(actual.count/2) - 1][0] = 1
        actual[(actual.count/2) + 1][1] = 1
        actual[(actual.count/2) - 1][1] = 1
        
        actual[1][actual[0].count/2] = 1
        actual[1][actual[0].count/2 - 1] = 1
        actual[1][actual[0].count/2 + 1] = 1
        actual[0][actual[0].count/2 + 1] = 1
        actual[0][actual[0].count/2 - 1] = 1
        
        actual[actual.count - 2][actual[0].count/2] = 1
        actual[actual.count - 1][actual[0].count/2 - 1] = 1
        actual[actual.count - 1][actual[0].count/2 + 1] = 1
        actual[actual.count - 2][actual[0].count/2 + 1] = 1
        actual[actual.count - 2][actual[0].count/2 - 1] = 1
        
//        corners
        if (getNeighbors(i: 0, j: 0) == 3) {
            actual[0][0] = 1
        }
        if (getNeighbors(i: 0, j: actual[0].count - 1) == 3) {
            actual[0][actual[0].count - 1] = 1
        }
        if (getNeighbors(i: actual.count - 1, j: actual[0].count - 1) == 3) {
            actual[actual.count - 1][actual[0].count - 1] = 1
        }
        if (getNeighbors(i: actual.count - 1, j: 0) == 3) {
            actual[actual.count - 1][0] = 1
        }
//        borders
        if (getNeighbors(i: actual.count/2, j: 0) == 5) {
            actual[actual.count/2][0] = 1
        }
        if (getNeighbors(i: actual.count/2, j: actual[0].count - 1) == 5) {
            actual[actual.count/2][actual[0].count - 1] = 1
        }
        if (getNeighbors(i: 0, j: actual[0].count/2) == 5) {
            actual[0][actual[0].count/2] = 1
        }
        if (getNeighbors(i: actual.count - 1, j: actual[0].count/2) == 5) {
            actual[actual.count - 1][actual[0].count/2] = 1
        }
        
        
    }
    
    func update2d () {
        DispatchQueue.main.asyncAfter(deadline: .now() + (1/32)) {
            for i in 0...(actual.count - 1) {
                for j in 0...(actual[0].count - 1) {
                    let neighbors = getNeighbors(i: i, j: j)
                    if (neighbors <= 1 || neighbors >= 4){
                        next[i][j] = 0
                    } else if (neighbors == 3) {
                        next[i][j] = 1
                    }
                }
            }
            actual = next
            frameCounter += 1
            update2d()
        }
    }
    
    var body: some View {
        VStack {
            
            Grid (horizontalSpacing: 1, verticalSpacing: 1) {
                ForEach (0..<actual.count) { i in
                    GridRow {
                        ForEach (0..<actual[0].count) { j in
                            
                            if (actual[i][j] == 0) {
                                Rectangle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
                                    
                            } else if (actual[i][j] == 1) {
                                Rectangle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
                                    .shadow(color: .cyan, radius: 5)
                                    
                            }
                        }
                    }
                }
            }
            
            VStack {
                Text(" Frames: \(frameCounter)")
                    .foregroundStyle(.green)
            }
            .onAppear{
                setupGame()
                update2d()
            }
        }
        .navigationTitle("Game of Life")
        .toolbar {
            ToolbarItem () {
                Button("Reset"){
                    setupGame()
                }
            }
        }
        .padding()
    }
}

#Preview {
    GameOfLifeView()
}
