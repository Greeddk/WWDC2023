//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/18.
//

import SwiftUI

struct CustomLadderView: View {
    var body: some View {
        VStack {
            Text("Ladder Lottery Gmae")
            Spacer()
            VStack(alignment: .leading) {
                Text("Description").font(.largeTitle)
                Text("1. Each participant starts at the top of the ladder and moves down the ladder using a horizontal line to the right or left.")
                Text("2. You can check the result by following the line directly from each starting point, or you can check the result at once")
                Text(" by pressing the result button at the bottom.")
            }
            .onAppear {
                SoundPlayer.shared.stop()
                SoundPlayer.shared.playSound(named: "New Rally X", withExtension: ".mp3")
            }
            CustomLadderGame()
            NavigationLink("Next Page") {
                Description()
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
        }
    
    }
}

struct CustomLadderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLadderView()
    }
}
