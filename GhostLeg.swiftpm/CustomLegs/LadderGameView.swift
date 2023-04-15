//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/13.
//


import SwiftUI
import SpriteKit

struct LadderGameView: View {
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack {
                Text("Ghost Leg Lottery")
                Spacer()
                
                LadderView()
                    .frame( height: geometry.size.height/7*5)

                
                Spacer()
                
                
            }
            
        }
    }
}



struct LadderGameView_Previews: PreviewProvider {
    static var previews: some View {
        LadderGameView()
    }
}
