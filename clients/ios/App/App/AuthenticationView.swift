import SwiftUI

struct AuthenticationView: View {
    var onMeta: () -> Void = {}
    var onGoogle: () -> Void = {}
    var onTikTok: () -> Void = {}
    var onOpenHelpCenter: () -> Void = {}
    var onCancel: () -> Void = {}

    var body: some View {
        ZStack {
            Color.oauthBackground
                .ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 42, weight: .light))
                        .foregroundStyle(Color.accentPrimary)
                        .padding(18)
                        .background(
                            Circle()
                                .fill(Color.accentPrimary.opacity(0.12))
                        )

                    VStack(spacing: 8) {
                        Text("Sign in to Live Studio")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(Color.primaryText)

                        Text("Choose your account to continue.")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.secondaryText)
                    }
                }

                VStack(spacing: 14) {
                    OAuthProviderButton(
                        title: "Continue with Meta",
                        icon: "link.circle.fill",
                        backgroundColor: .metaBlue,
                        foregroundColor: .white
                    ) {
                        onMeta()
                    }

                    OAuthProviderButton(
                        title: "Continue with Google",
                        icon: "globe",
                        backgroundColor: .white,
                        foregroundColor: Color.primaryText,
                        borderColor: Color.cardBorder
                    ) {
                        onGoogle()
                    }

                    OAuthProviderButton(
                        title: "Continue with TikTok",
                        icon: "music.quarternote.3",
                        backgroundColor: .black,
                        foregroundColor: .white
                    ) {
                        onTikTok()
                    }
                }

                VStack(spacing: 4) {
                    Text("By continuing you agree to Live Studio's Terms and Privacy Policy.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Button(action: onOpenHelpCenter) {
                        Text("Need help signing in?")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.accentPrimary)
                    }
                    .buttonStyle(.plain)
                }

                Button(action: onCancel) {
                    Text("Cancel")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.secondaryText)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 8)
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 30, x: 0, y: 24)
            )
            .padding(.horizontal, 24)
        }
    }
}

private struct OAuthProviderButton: View {
    var title: String
    var icon: String
    var backgroundColor: Color
    var foregroundColor: Color
    var borderColor: Color? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 32, height: 32)
                    .foregroundStyle(foregroundColor.opacity(0.9))

                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(foregroundColor)

                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(backgroundColor)
            )
            .overlay(
                Group {
                    if let borderColor {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(borderColor, lineWidth: 1.5)
                    }
                }
            )
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
}

private extension Color {
    static let oauthBackground = Color(red: 242 / 255, green: 244 / 255, blue: 247 / 255)
    static let primaryText = Color(red: 15 / 255, green: 23 / 255, blue: 42 / 255)
    static let secondaryText = Color(red: 100 / 255, green: 116 / 255, blue: 139 / 255)
    static let cardBorder = Color(red: 226 / 255, green: 232 / 255, blue: 240 / 255)
    static let metaBlue = Color(red: 24 / 255, green: 119 / 255, blue: 242 / 255)
    static let accentPrimary = Color(red: 99 / 255, green: 102 / 255, blue: 241 / 255)
}

#Preview {
    AuthenticationView()
        .previewLayout(.sizeThatFits)
}
