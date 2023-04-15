//
//  GhostLag.swift
//  GhostLeg
//
//  Created by Greed on 2023/04/11.
//

import SwiftUI
import SpriteKit

struct GhostLag: View {
    @EnvironmentObject var data: Data
    
    var body: some View {
        VStack {
            
            Text("Ghost Leg Game")
                .font(.largeTitle)
                .padding()
            
            
        }
    }
    
}



struct GhostLag_Previews: PreviewProvider {
    static var previews: some View {
        GhostLag()
            .environmentObject(Data())
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        
    }
}


