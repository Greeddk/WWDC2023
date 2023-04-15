//
//  InputView.swift
//  GhostLeg
//
//  Created by Greed on 2023/04/11.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var data: Data
    
    var body: some View {
        
        VStack{
            
            Text("How many people?")
            
            Spacer().frame(height: 40)
            
            HStack {
                
                Button(action: {data.numberOfPeople -= 1} ){
                                Image(systemName: "minus.circle")
                                    .imageScale(.large)
                                    .font(.largeTitle)
                }.disabled(data.numberOfPeople == 3 ? true : false )
                
                Spacer().frame(width: 30)
                
                Text("\(data.numberOfPeople)")
                    .font(.largeTitle)
                
                Spacer().frame(width: 30)
                
                Button(action:{data.numberOfPeople += 1}){
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                                    .font(.largeTitle)
                }.disabled(data.numberOfPeople == 8 ? true : false)
                
                
            }
            
            Spacer().frame(height: 100)
            
            Text("How many winner?")
            
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
            
            NavigationLink("Next") {
                LadderView()
                
            }.navigationBarTitle("Setting")

            
        }
    }
}

struct InputView_Previews: PreviewProvider {
  static var previews: some View {
      InputView()
          .environmentObject(Data())
  }
}
