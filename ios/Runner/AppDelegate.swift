import AudioToolbox
import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private static let bundledSounds = ["chime", "bell", "bright", "soft"]
  private var previewSound: SystemSoundID = 0

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let key = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String, !key.isEmpty {
      GMSServices.provideAPIKey(key)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "NotificationSounds")
    else { return }
    installSounds(registrar)
    FlutterMethodChannel(name: "codami/notification_sounds", binaryMessenger: registrar.messenger())
      .setMethodCallHandler { [weak self] call, result in
        self?.onSoundCall(call, result: result)
      }
  }

  private var soundsFolder: URL? {
    FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?
      .appendingPathComponent("Sounds", isDirectory: true)
  }

  // iOS only plays custom notification sounds from the app bundle or Library/Sounds.
  private func installSounds(_ registrar: FlutterPluginRegistrar) {
    guard let folder = soundsFolder else { return }
    let files = FileManager.default
    try? files.createDirectory(at: folder, withIntermediateDirectories: true)
    for name in Self.bundledSounds {
      let target = folder.appendingPathComponent("\(name).wav")
      guard !files.fileExists(atPath: target.path),
        let source = Bundle.main.path(
          forResource: registrar.lookupKey(forAsset: "assets/sounds/\(name).wav"), ofType: nil)
      else { continue }
      try? files.copyItem(atPath: source, toPath: target.path)
    }
  }

  private func onSoundCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    switch call.method {
    case "capabilities":
      result(["channels": false, "systemSounds": false, "files": false])
    case "play":
      stopPreview()
      switch args?["kind"] as? String {
      case "bundled":
        guard let name = args?["value"] as? String,
          let url = soundsFolder?.appendingPathComponent("\(name).wav")
        else { break }
        AudioServicesCreateSystemSoundID(url as CFURL, &previewSound)
        AudioServicesPlaySystemSound(previewSound)
      case "silent":
        break
      default:
        AudioServicesPlaySystemSound(1007)
      }
      result(nil)
    case "stop":
      stopPreview()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func stopPreview() {
    if previewSound != 0 {
      AudioServicesDisposeSystemSoundID(previewSound)
      previewSound = 0
    }
  }
}
