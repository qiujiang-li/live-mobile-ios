import SwiftUI
import UIKit
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    private let session = AVCaptureSession()

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.session = session
        context.coordinator.startSession(with: session)
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator {
        private let sessionQueue = DispatchQueue(label: "camera.session.queue")

        func startSession(with session: AVCaptureSession) {
            sessionQueue.async {
                configure(session: session)
                if !session.isRunning {
                    session.startRunning()
                }
            }
        }

        private func configure(session: AVCaptureSession) {
            session.beginConfiguration()
            session.sessionPreset = .high

            session.inputs.forEach { session.removeInput($0) }

            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let input = try? AVCaptureDeviceInput(device: camera) else {
                session.commitConfiguration()
                return
            }

            if session.canAddInput(input) {
                session.addInput(input)
            }

            let previewOutput = AVCaptureVideoDataOutput()
            if session.canAddOutput(previewOutput) {
                session.addOutput(previewOutput)
            }

            session.commitConfiguration()
        }
    }
}

final class PreviewView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }

    var session: AVCaptureSession? {
        get { videoPreviewLayer.session }
        set {
            videoPreviewLayer.session = newValue
            videoPreviewLayer.videoGravity = .resizeAspectFill
        }
    }
}
