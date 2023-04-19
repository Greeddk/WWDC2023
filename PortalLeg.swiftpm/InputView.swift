//
//  InputView.swift
//  GhostLeg
//
//  Created by Greed on 2023/04/11.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var data: Data
    
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack{
            Text("How many Player?")
            Spacer().frame(height: 40)
            HStack {
                Button(action: {
                    data.numberOfPeople -= 1
                }){
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                }.disabled(data.numberOfPeople == 3 ? true : false )
                Spacer().frame(width: 30)
                Text("\(data.numberOfPeople)")
                    .font(.largeTitle)
                Spacer().frame(width: 30)
                Button(action:{
                    data.numberOfPeople += 1
                }){
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                }.disabled(data.numberOfPeople == 8 ? true : false)
            }
            Spacer().frame(height: 100)
            Text("How many Winner?")
            Spacer().frame(height: 40)
            HStack {
                Button(action: {data.numberOfWinner -= 1} ){
                    Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                }.disabled(data.numberOfWinner == 1 ? true : false )
                Spacer().frame(width: 30)
                Text("\(data.numberOfWinner)")
                    .font(.largeTitle)
                Spacer().frame(width: 30)
                Button(action:{data.numberOfWinner += 1}){
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                }.disabled(data.numberOfWinner >= (data.numberOfPeople - 1) ? true : false)
            }
            Spacer().frame(height: 40)
            //다음페이지로 넘어가기
            if(data.numberOfPeople>data.numberOfWinner){
                NavigationLink("Next") {
                    CustomLadderView()
                }
                .navigationBarTitle("Setting")
                .font(.largeTitle)
                .foregroundColor(.blue)
            } else {
                Text("The number of winners cannot exceed the number of players.").font(.largeTitle).foregroundColor(.red)
            }
        }
    }
    
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .environmentObject(Data())
    }
}
