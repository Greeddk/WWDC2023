import SwiftUI

@main
struct MyApp: App {
    @StateObject var data = Data()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
            
        }
    }
}


