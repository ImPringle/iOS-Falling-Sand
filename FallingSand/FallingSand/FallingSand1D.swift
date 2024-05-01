//
//  FallingSand1D.swift
//  FallingSand
//
//  Created by Mario Pringle on 29/04/24.
//

import SwiftUI

struct FallingSand1D: View {
    @State var actualTable: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State var nextTable: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State var isChanged: Bool = false

    @State private var counter: Int = 0
    
    func update () {
        DispatchQueue.main.asyncAfter(deadline: .now() + (1/16)) {
            
            counter = counter + 1
            actualTable[0] = 1
            for index in 0...(actualTable.count - 2) {
                if (actualTable[index] == 1 && actualTable[index + 1] == 0) {
                    nextTable[index] = 0
                    nextTable[index + 1] = 1
                    isChanged = true
                }
            }
            if isChanged {
                actualTable = nextTable
                isChanged = false
            }
            
            update()
        }
    }
    
    
    
    var body: some View {
        VStack {
            
            ForEach(actualTable, id: \.self) { item in
                
                if (item == 0) {
                    Rectangle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                } else {
                    Rectangle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.yellow)
                }
                
                
            }
            
            Text("\(counter)")
                .font(.largeTitle)
                .onAppear {
                   update()
                }
            
        }
        .padding()
        .navigationTitle("Falling Sand 1D")
    }
}

#Preview {
    FallingSand1D()
}
