import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Spacer()
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Image("SpiderWeb")
                    .resizable()
                    .scaledToFit()
                Spacer().frame(height: 40)
                
                NavigationLink("Start") {
                    InputView()
                }
                .font(.system(size: 50))
                .foregroundColor(.blue)
                
                Spacer().frame(height: 40)
                
                NavigationLink("Custom") {
                    
                }
                .font(.system(size: 50))
                .foregroundColor(.teal)
                
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        
    }
}

