//
//  MotionDetector.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import Combine
import CoreMotion
import SwiftUI

// ObservableObject class for motion detection
class MotionDetector: ObservableObject {
  // Core Motion manager instance
  private let motionManager = CMMotionManager()
  // Set to hold cancellables for Combine
  private var cancellables: Set<AnyCancellable> = []
  // Time interval for motion data updates
  private var updateInterval: TimeInterval

  // Published properties for motion data
  @Published var pitch: Double = 0
  @Published var roll: Double = 0
  @Published var zAcceleration: Double = 0
  @Published var currentOrientation: DeviceOrientation = .landscapeLeft

  // Closure to be called on motion data update
  var onUpdate: (() -> Void) = {}

  // Initializer with update interval
  init(updateInterval: TimeInterval) {
    self.updateInterval = updateInterval
    setupOrientationObserver()
  }

  // Start motion updates
  func start() {
    if motionManager.isDeviceMotionAvailable {
      motionManager.startDeviceMotionUpdates()
      // Timer to periodically update motion data
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

  // Setup observer for device orientation changes
  private func setupOrientationObserver() {
    NotificationCenter.default.publisher(
      for: UIDevice.orientationDidChangeNotification
    )
    .compactMap { notification in
      (notification.object as? UIDevice)?.orientation
    }
    .map { DeviceOrientation($0) }
    .assign(to: \.currentOrientation, on: self)
    .store(in: &cancellables)
  }

  // Update motion data based on device motion
  func updateMotionData() {
    if let data = motionManager.deviceMotion {
      (roll, pitch) = currentOrientation.adjustedRollAndPitch(data.attitude)
      zAcceleration = data.userAcceleration.z
      onUpdate()
    }
  }

  // Stop motion updates and cancel subscriptions
  func stop() {
    motionManager.stopDeviceMotionUpdates()
    cancellables.forEach { $0.cancel() }
  }

  // Deinitializer to ensure stopping motion updates
  deinit {
    stop()
  }
}

// SwiftUI view to display motion data
struct MotionView: View {
  // ObservedObject to detect motion
  @ObservedObject var motionDetector = MotionDetector(updateInterval: 1.0)
    .started()

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

// Extension to start motion detector
extension MotionDetector {
  func started() -> MotionDetector {
    start()
    return self
  }
}

// Enum for device orientation with associated adjustments for roll and pitch
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

  // Adjust roll and pitch based on device orientation
  func adjustedRollAndPitch(_ attitude: CMAttitude) -> (
    roll: Double, pitch: Double
  ) {
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
