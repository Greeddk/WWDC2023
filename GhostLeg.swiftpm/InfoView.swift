//
//  InfoView.swift
//  GhostLeg
//
//  Created by Greed on 2023/04/19.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.app")
                    .resizable()
                    .frame(width: 32,height: 32)
            }
        }
        CardView{
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                    }
                    Text("BackGroundMusic")
                        .font(.title)
                    Spacer().frame(height: 30)
                    HStack{
                        Text("Title : Fun  ")
                        Text("Artist : Vibe Tracks")
                    }
                    HStack{
                        Text("Title : Rally X In Game Music ")
                        Text("Composed By Hiroshi Okubo")
                    }
                }
            }
        }//CardView
        .padding(20)
        Spacer()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
