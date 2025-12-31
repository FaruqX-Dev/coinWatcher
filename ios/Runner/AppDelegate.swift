import Flutter
import UIKit
import flutter_local_notifications // Import the plugin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Add the following line:
    FlutterLocalNotificationsPlugin.set </latest_version> upPluginCallBackQueue()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
