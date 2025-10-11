import SwiftUI

enum OAuthProvider: String {
    case meta = "Meta"
    case google = "Google"
    case tiktok = "TikTok"
}

struct ContentView: View {
    @State private var lastSelectedProvider: OAuthProvider? = nil
    @State private var isShowingConfirmation = false

    var body: some View {
        AuthenticationView(
            onMeta: { startOAuth(for: .meta) },
            onGoogle: { startOAuth(for: .google) },
            onTikTok: { startOAuth(for: .tiktok) },
            onOpenHelpCenter: openHelpCenter,
            onCancel: cancelAuthentication
        )
        .alert("Starting OAuth", isPresented: $isShowingConfirmation, presenting: lastSelectedProvider) { _ in
            Button("OK", role: .cancel) {}
        } message: { provider in
            Text("Initiating OAuth 2.0 flow for \(provider.rawValue).")
        }
    }

    private func startOAuth(for provider: OAuthProvider) {
        lastSelectedProvider = provider
        // Integrate provider specific OAuth 2.0 flows here.
        isShowingConfirmation = true
    }

    private func openHelpCenter() {
        // Integrate navigation to help center when available.
    }

    private func cancelAuthentication() {
        // Integrate cancellation handling when wiring into navigation stack.
    }
}

#Preview {
    ContentView()
}
