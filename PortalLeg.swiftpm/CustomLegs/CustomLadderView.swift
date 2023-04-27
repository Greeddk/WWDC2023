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
            Text("Portal Ladder Game")
                .font(.title)
            Spacer()
            VStack(alignment: .leading) {
                Text("How to play?").font(.largeTitle).foregroundColor(.teal)
                Text("1. each participant starts at the top of the ladder and follows a horizontal line down the ladder to the right or left. \n2. Tap a player's name at the top of the ladder to see the corresponding result, or click the Results button at the bottom to see the results all at once.")
            }
            CustomLadderGame()
            NavigationLink("Home") {
                ContentView()
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
            .simultaneousGesture(TapGesture().onEnded {
                SoundPlayer.shared.stop()
                SoundPlayer.shared.playSound(named: "Fun", withExtension: ".mp3")
                        })
                        .buttonStyle(PlainButtonStyle())
            
        }
        .onAppear {
            SoundPlayer.shared.stop()
            SoundPlayer.shared.playSound(named: "New Rally X", withExtension: ".mp3")
        }
    }
}

struct CustomLadderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLadderView()
    }
}
