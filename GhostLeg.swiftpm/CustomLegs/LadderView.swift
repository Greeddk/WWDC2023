//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/13.
//


import SwiftUI

struct LadderView: View {
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack {
                Text("Ghost Leg Lottery")
                Spacer()
                
                Text("여기엔 간단한 사다리타기 게임 설명이 들어가지요")
                
                LadderGame()
                    .frame( height: geometry.size.height/6*5)

                
                NavigationLink("Next Page") {
                    Description()
                }
                .font(.largeTitle)
                .foregroundColor(.blue)
                
                
                
            }
            
        }
    }
}



struct LadderView_Previews: PreviewProvider {
    static var previews: some View {
        LadderView()
            .environmentObject(Data())
    }
}
