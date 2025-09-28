# Platform Skeleton & Build Tooling
Create a cross-platform mobile app target (e.g., iOS with SwiftUI + AVFoundation, Android with Kotlin + CameraX) and set up continuous integration to produce debug builds on each merge.
Configure environment-driven endpoints so the client can switch between local, staging, and production ingest gateways without code changes.
# Camera & Microphone Capture Loop
Implement a capture controller that locks camera to 720p@30 fps (configurable), handles device orientation, and exposes a unified frame callback (pixel buffer + timestamp).
Wire microphone capture at 16 kHz mono, ensuring audio frames carry synchronized timestamps with the video frames for downstream lip-sync alignment.
Add graceful degradation modes (e.g., drop to 480p or 15 fps) when the device reports thermal or battery pressure.
# On-Device Encoding & Preprocessing
Integrate hardware-accelerated encoders: VideoToolbox/MediaCodec for H.264 (baseline) and optionally VP8; use Opus/AAC for audio.
Implement a ring buffer that maintains ~200 ms of encoded payloads to smooth jitter before handoff to the network layer.
Include optional preprocessing hooks (face cropping, exposure compensation) to improve the avatar’s alignment while keeping raw frames accessible for debugging.
# Real-Time Transport (WebRTC Preferred)
Use a mobile WebRTC SDK (Google WebRTC, Pion bindings, etc.) to handle DTLS/SRTP, NAT traversal, and congestion control.
Define a session-description exchange with the backend ingestion service via REST or WebSocket signaling; include JWT bearer tokens in the initial offer.
Configure prioritized data channels: media streams for audio/video, optional control channel for downstream viseme/debug messages.
# Session Authentication & Metadata
Implement login/token refresh flow (e.g., OAuth device code or app-issued credentials) and persist tokens securely in the device keystore.
Attach metadata (user ID, device model, app version, timestamp) as SDP session attributes or custom signaling payloads so the backend can route to the correct Unity renderer instance.
Expose a foreground indicator (LED or overlay) that surfaces when the camera/mic are active to satisfy privacy expectations.
# Developer Telemetry & Diagnostics UI
Add an in-app debug HUD showing bitrate, RTT, packet loss, encoder FPS, and backend-reported render latency.
Capture structured logs with correlation IDs matching backend sessions; allow exporting logs/traces for troubleshooting.
Integrate lightweight crash reporting and network trace uploads gated behind a developer flag.
# Local Test Harness & Automation
Provide loopback testing by allowing the prototype to subscribe to a known-good test stream (static Unity output) for quick validation without the full backend.
Script automated smoke tests (XCUITest/Espresso) that launch the capture flow, stream for 30 seconds, and assert that telemetry metrics stay within defined thresholds.
Document setup steps for engineers, including required entitlements (camera/mic permissions) and how to point the app to local docker-compose stacks.
Milestones & Deliverables
Week 1: Capture loop + encoding verified on reference device; metrics logged locally.
Week 2: WebRTC handshake with stub backend, authenticated sessions, and live telemetry overlay.
Week 3: Stabilization, automated smoke tests, and packaged TestFlight/Internal App Sharing build with documentation.
Testing
Not run (design-only response).
