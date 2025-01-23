import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
private var deviceInfoChannel: FlutterMethodChannel?

//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
 override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    deviceInfoChannel = FlutterMethodChannel(name: "com.yourcompany.deviceInfo", binaryMessenger: controller.binaryMessenger)

    deviceInfoChannel?.setMethodCallHandler { [weak self] (call, result) in
      guard call.method == "getDeviceInfo" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.getDeviceInformation(result: result)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func getDeviceInformation(result: @escaping FlutterResult) {
    let device = UIDevice.current
    var systemInfo = utsname()
    uname(&systemInfo)
    let modelName = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
      return String(cString: ptr)
    }

    let deviceInfo: [String: String] = [
      "Device Name": device.name,
      "Model Name": modelName,
      "System Name": device.systemName,
      "System Version": device.systemVersion,
      "Localized Model": device.localizedModel
    ]

    result(deviceInfo)
  }
}
