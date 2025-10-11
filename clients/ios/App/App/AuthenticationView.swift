import SwiftUI

struct AuthenticationView: View {
    var onMeta: () -> Void = {}
    var onGoogle: () -> Void = {}
    var onTikTok: () -> Void = {}
    var onUseDifferentProvider: () -> Void = {}
    var onOpenHelpCenter: () -> Void = {}
    var onCancel: () -> Void = {}

    var body: some View {
        ZStack {
            Color.oauthBackground
                .ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 12) {
                    Text("Connect Platform Account")
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .foregroundStyle(Color.primaryText)
                        .multilineTextAlignment(.center)

                    Text("Choose a provider to continue with OAuth 2.0")
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundStyle(Color.secondaryText)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)

                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Text("Select platform to authenticate")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundStyle(Color.primaryText)
                            .multilineTextAlignment(.center)

                        Text("Link your account so streams can publish on your behalf.")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundStyle(Color.secondaryText)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)

                        VStack(spacing: 16) {
                            OAuthProviderButton(title: "Continue with Meta", backgroundColor: .metaBlue, foregroundColor: .white) {
                                onMeta()
                            }

                            OAuthProviderButton(title: "Continue with Google", backgroundColor: .white, foregroundColor: Color.primaryText, borderColor: Color.cardBorder) {
                                onGoogle()
                            }

                            OAuthProviderButton(title: "Continue with TikTok", backgroundColor: .black, foregroundColor: .white) {
                                onTikTok()
                            }
                        }

                        Text("We never post without permission. You can revoke access at any time.")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundStyle(Color.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }

                    Button(action: onUseDifferentProvider) {
                        Text("Use different provider")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundStyle(Color.primaryText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.primaryText, style: StrokeStyle(lineWidth: 2, dash: [12, 8]))
                    )

                    VStack(spacing: 8) {
                        Text("Having trouble?")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundStyle(Color.secondaryText)

                        Button(action: onOpenHelpCenter) {
                            Text("Open help center")
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .foregroundStyle(Color.metaBlue)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(32)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32, style: .continuous)
                                .stroke(Color.cardBorder, lineWidth: 2)
                        )
                )
                .padding(.horizontal, 32)

                Button(action: onCancel) {
                    Text("Cancel")
                        .font(.system(size: 22, weight: .semibold, design: .default))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.primaryText)
                        .cornerRadius(20)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 80)
                .padding(.bottom, 16)
            }
            .padding(.vertical, 24)
        }
    }
}

private struct OAuthProviderButton: View {
    var title: String
    var backgroundColor: Color
    var foregroundColor: Color
    var borderColor: Color? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .foregroundStyle(foregroundColor)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(backgroundColor)
                )
                .overlay(
                    Group {
                        if let borderColor {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(borderColor, lineWidth: 2)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
    }
}

private extension Color {
    static let oauthBackground = Color(red: 0xf5 / 255, green: 0xf7 / 255, blue: 0xfb / 255)
    static let primaryText = Color(red: 0x0a / 255, green: 0x0f / 255, blue: 0x29 / 255)
    static let secondaryText = Color(red: 0x4a / 255, green: 0x4f / 255, blue: 0x63 / 255)
    static let cardBorder = Color(red: 0xd8 / 255, green: 0xdb / 255, blue: 0xe6 / 255)
    static let metaBlue = Color(red: 0x18 / 255, green: 0x77 / 255, blue: 0xf2 / 255)
}

#Preview {
    AuthenticationView()
        .previewLayout(.sizeThatFits)
}
