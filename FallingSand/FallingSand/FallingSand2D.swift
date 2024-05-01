//
//  FallingSand2D.swift
//  FallingSand
//
//  Created by Mario Pringle on 29/04/24.
//

import SwiftUI

struct FallingSand2D: View {
    
    @State var actual = [[Int]](repeating: [Int](repeating: 0, count: 30), count: 60)
    @State var next = [[Int]](repeating: [Int](repeating: 0, count: 30), count: 60)
    @State var isChanged: Bool = false
    
    @State private var counter: Int = 0
    
    func generateSand () {
        let randomNumber = Int.random(in: ((actual[0].count/2) - 2)...((actual[0].count/2) + 2))
        actual[0][randomNumber] = 1
//        actual[0][14] = 1
    }
    
    func update2d () {
        DispatchQueue.main.asyncAfter(deadline: .now() + (1/32)) {
            
            counter = counter + 1
//            actual[0][7] = 1
            generateSand()
            for i in 0...(actual.count - 2) {
                for j in 0...(actual[0].count - 1) {
                    if (actual[i][j] == 1 && actual[i + 1][j] == 0) {
                        next[i][j] = 0
                        next[i + 1][j] = 1
                        isChanged = true
                    } else if (actual[i][j] == 1 && actual[i + 1][j] == 1) {
                        if (j == 0) {
                            if (actual[i + 1][j + 1] == 0) {
                                next[i][j] = 0
                                next[i + 1][j + 1] = 1
                                isChanged = true
                            }
                        } else if (j == (actual[0].count - 1)) {
                            if (actual[i + 1][j - 1] == 0) {
                                next[i][j] = 0
                                next[i + 1][j - 1] = 1
                                isChanged = true
                            }
                        } else {
                            let randomNumber = Int.random(in: 0...1)
                            if (randomNumber == 0) {
                                if (actual[i + 1][j + 1] == 0) {
                                    next[i][j] = 0
                                    next[i + 1][j + 1] = 1
                                    isChanged = true
                                } else if (actual[i + 1][j - 1] == 0) {
                                    next[i][j] = 0
                                    next[i + 1][j - 1] = 1
                                    isChanged = true
                                }
                            } else {
                                if (actual[i + 1][j - 1] == 0) {
                                    next[i][j] = 0
                                    next[i + 1][j - 1] = 1
                                    isChanged = true
                                } else if (actual[i + 1][j + 1] == 0) {
                                    next[i][j] = 0
                                    next[i + 1][j + 1] = 1
                                    isChanged = true
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            if isChanged {
                actual = next
                isChanged = false
            }
            
            
            update2d()
        }
    }

    var body: some View {
        VStack {
            Grid (horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<(actual.count)) { i in
                    GridRow {
                        ForEach(0..<(actual[0].count)) { j in
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                                .foregroundColor(.black)
                            if (actual[i][j] == 0) {
                                Rectangle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.black)
                            } else {
                                Rectangle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            Text("\(counter)")
                .onAppear {
                    update2d()
                }
//            Text("actual.count: \(actual.count)")
        }
        .navigationTitle("Falling Sand 2D")
    }
}

#Preview {
    FallingSand2D()
}
