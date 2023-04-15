import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("GhostLeg")
                    .font(.system(size: 100))
            
                
                Spacer().frame(height: 40)
                
                NavigationLink("Start") {
                    
                }
                
                Spacer().frame(height: 40)
                
                NavigationLink("Custom") {
                    InputView()
                }
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

