//
//  SwiftUIView.swift
//  
//
//  Created by Greed on 2023/04/16.
//

import SwiftUI


struct SpiderWebView: View {
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack {
                Text("SpiderWeb Lottery")
                Spacer()
                
                SpiderWebGame()
                    .frame( height: geometry.size.height/6*5)

                
                Button(action: {
                    
                    
                }, label: {Text("Next Page").font(.largeTitle).foregroundColor(.blue)})
                
                
            }
            
        }
    }
}



struct SpiderWebView_Previews: PreviewProvider {
    static var previews: some View {
        SpiderWebView()
            .environmentObject(Data())
    }
}

