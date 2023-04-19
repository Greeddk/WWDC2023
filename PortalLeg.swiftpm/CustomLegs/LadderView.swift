//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/13.
//


import SwiftUI

struct LadderView: View {
    
    
    var body: some View {
        
            VStack {
                Text("Ladder Lottery Game")
                Spacer()
                VStack(alignment: .leading) {
                    Text("How to play?").font(.largeTitle).foregroundColor(.teal)
                    Text("1. each participant starts at the top of the ladder and follows a horizontal line down the ladder to the right or left. \n2. Tap the player name at each starting point to see the corresponding result, or click the Results button at the bottom to see the results all at once.")
                }
                
                LadderGame()
                NavigationLink("Next Page") {
                    Description()
                }
                .font(.largeTitle)
                .foregroundColor(.blue)                
            }
            .onAppear {
                SoundPlayer.shared.stop()
                SoundPlayer.shared.playSound(named: "New Rally X", withExtension: ".mp3")
            }
    }
}

struct LadderView_Previews: PreviewProvider {
    static var previews: some View {
        LadderView()
            .environmentObject(Data())
    }
}
