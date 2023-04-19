import SwiftUI

struct ContentView: View {
    
    @State private var showInfoModal: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                HStack{
                    Button {
                        showInfoModal = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width:24,height: 24)
                    }
                    .sheet(isPresented: $showInfoModal){
                        InfoView()
                    }
                    Spacer()
                }
                .padding(20)
                Spacer()
                HStack{
                    Image("PortalLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("Portal Ladder Game")
                        .font(.largeTitle)
                    Image("PortalRight")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
                NavigationLink("Start") {
                    LadderView()
                }
                .font(.system(size: 50))
                .foregroundColor(.blue)
                
                Spacer().frame(height: 40)
                
                NavigationLink("Custom") {
                    InputView()
                }
                .font(.system(size: 50))
                .foregroundColor(.teal)
                
                Spacer()
            }
        }
        .onAppear {
            SoundPlayer.shared.playSound(named: "Fun", withExtension: ".mp3")
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

