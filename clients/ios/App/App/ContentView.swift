import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            CameraPreview()
                .ignoresSafeArea()

            TalkingAvatarView()
                .padding(.bottom, 32)
                .allowsHitTesting(false)
        }
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}
