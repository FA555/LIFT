//
//  MotionDetector.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import Combine
import CoreMotion
import SwiftUI

class MotionDetector: ObservableObject {
  private let motionManager = CMMotionManager()
  private var cancellables: Set<AnyCancellable> = []
  private var updateInterval: TimeInterval

  @Published var pitch: Double = 0
  @Published var roll: Double = 0
  @Published var zAcceleration: Double = 0
  @Published var currentOrientation: DeviceOrientation = .landscapeLeft

  var onUpdate: (() -> Void) = {}

  init(updateInterval: TimeInterval) {
    self.updateInterval = updateInterval
    setupOrientationObserver()
  }

  func start() {
    if motionManager.isDeviceMotionAvailable {
      motionManager.startDeviceMotionUpdates()
      Timer.publish(every: updateInterval, on: .main, in: .common)
        .autoconnect()
        .sink { [weak self] _ in
          self?.updateMotionData()
        }
        .store(in: &cancellables)
    } else {
      print("Device motion not available")
    }
  }

  private func setupOrientationObserver() {
    NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
      .compactMap { notification in
        (notification.object as? UIDevice)?.orientation
      }
      .map { DeviceOrientation($0) }
      .assign(to: \.currentOrientation, on: self)
      .store(in: &cancellables)
  }

  func updateMotionData() {
    if let data = motionManager.deviceMotion {
      (roll, pitch) = currentOrientation.adjustedRollAndPitch(data.attitude)
      zAcceleration = data.userAcceleration.z
      onUpdate()
    }
  }

  func stop() {
    motionManager.stopDeviceMotionUpdates()
    cancellables.forEach { $0.cancel() }
  }

  deinit {
    stop()
  }
}

struct MotionView: View {
  @ObservedObject var motionDetector = MotionDetector(updateInterval: 1.0).started()

  var body: some View {
    VStack {
      Text("Pitch: \(motionDetector.pitch)")
      Text("Roll: \(motionDetector.roll)")
      Text("Z Acceleration: \(motionDetector.zAcceleration)")
    }
    .onAppear {
      motionDetector.start()
    }
    .onDisappear {
      motionDetector.stop()
    }
  }
}

#Preview {
  MotionView()
}

extension MotionDetector {
  func started() -> MotionDetector {
    start()
    return self
  }
}

enum DeviceOrientation {
  case portrait
  case portraitUpsideDown
  case landscapeLeft
  case landscapeRight
  case faceUp
  case faceDown
  case unknown

  init(_ uiDeviceOrientation: UIDeviceOrientation) {
    switch uiDeviceOrientation {
    case .portrait: self = .portrait
    case .portraitUpsideDown: self = .portraitUpsideDown
    case .landscapeLeft: self = .landscapeLeft
    case .landscapeRight: self = .landscapeRight
    case .faceUp: self = .faceUp
    case .faceDown: self = .faceDown
    case .unknown: self = .unknown
    @unknown default: self = .unknown
    }
  }

  func adjustedRollAndPitch(_ attitude: CMAttitude) -> (roll: Double, pitch: Double) {
    switch self {
    case .unknown, .faceUp, .faceDown:
      return (attitude.roll, -attitude.pitch)
    case .landscapeLeft:
      return (attitude.pitch, -attitude.roll)
    case .portrait:
      return (attitude.roll, attitude.pitch)
    case .portraitUpsideDown:
      return (-attitude.roll, -attitude.pitch)
    case .landscapeRight:
      return (-attitude.pitch, attitude.roll)
    }
  }
}
