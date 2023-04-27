import SwiftUI

struct CardView<Content>: View where Content: View {
    
    var elevation: CGFloat = 8
    var cornerRadius: CGFloat = 16
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            content()
                .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: elevation, x: 0, y: elevation / 2)
                .padding(1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("asdf")
                .padding()
        }
    }
}
