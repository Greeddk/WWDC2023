import SwiftUI

struct ContentView: View {
    
    @State private var showInfoModal: Bool = false
    
    var body: some View {
        ZStack {
            Image("main")
                .resizable()
                .ignoresSafeArea(.all)
                VStack {
                    HStack{
                        Button {
                            showInfoModal = true
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width:24,height: 24)
                                .foregroundColor(.white)
                        }
                        .sheet(isPresented: $showInfoModal){
                            InfoView()
                        }
                        Spacer()
                    }
                    .padding(20)
                    
                    Spacer().frame(height: 1000)
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
        .navigationBarBackButtonHidden(true)
            .onAppear {
                SoundPlayer.shared.playSound(named: "Fun", withExtension: ".mp3")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        
    }
}

