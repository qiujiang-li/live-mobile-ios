import SwiftUI

struct TalkingAvatarView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var mouthIndex: Int = 0
    @State private var isAnimating: Bool = true

    private let mouthHeights: [CGFloat] = [4, 12, 2, 10, 6, 14, 3, 8]
    private let timer = Timer.publish(every: 0.18, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            avatarHead
            Text("Let's explore together!")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.95))
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 32)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 24, x: 0, y: 18)
        .padding()
        .onReceive(timer) { _ in
            guard isAnimating else { return }
            withAnimation(.easeInOut(duration: 0.18)) {
                mouthIndex = (mouthIndex + 1) % mouthHeights.count
            }
        }
        .onChange(of: scenePhase) { newPhase in
            isAnimating = newPhase == .active
        }
    }

    private var avatarHead: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(red: 0.93, green: 0.73, blue: 0.98), Color(red: 0.56, green: 0.39, blue: 0.87)],
                        center: .center,
                        startRadius: 10,
                        endRadius: 140
                    )
                )
                .frame(width: 180, height: 180)
                .overlay(alignment: .top) {
                    Capsule()
                        .fill(Color(red: 0.35, green: 0.21, blue: 0.68))
                        .frame(width: 170, height: 70)
                        .offset(y: -60)
                }

            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 110, height: 110)
                .offset(y: 40)

            VStack(spacing: 24) {
                eyes
                mouth
            }
        }
        .overlay(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.14, green: 0.16, blue: 0.36), Color(red: 0.22, green: 0.28, blue: 0.58)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 120, height: 70)
                .offset(y: 90)
        }
    }

    private var eyes: some View {
        HStack(spacing: 50) {
            eye
            eye
        }
        .padding(.top, 32)
    }

    private var eye: some View {
        ZStack {
            Capsule()
                .fill(Color.white.opacity(0.95))
                .frame(width: 42, height: 24)
            Circle()
                .fill(Color(red: 0.19, green: 0.24, blue: 0.51))
                .frame(width: 16, height: 16)
                .overlay(
                    Circle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 6, height: 6)
                        .offset(x: -3, y: -3)
                )
        }
    }

    private var mouth: some View {
        Capsule()
            .fill(Color(red: 0.88, green: 0.3, blue: 0.55))
            .frame(width: 90, height: currentMouthHeight)
            .overlay(
                Capsule()
                    .fill(Color.white.opacity(0.35))
                    .frame(width: 70, height: max(currentMouthHeight - 4, 2))
                    .offset(y: -currentMouthHeight * 0.15)
            )
            .padding(.bottom, 24)
    }

    private var currentMouthHeight: CGFloat {
        max(mouthHeights[mouthIndex], 4)
    }
}

#Preview {
    ZStack {
        Color.black
        TalkingAvatarView()
    }
}
