import Flutter
import UIKit
import GoogleMaps // Import the Google Maps library

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Provide your Google Maps API key here
    GMSServices.provideAPIKey("AIzaSyBPKmwop1nGAEploMPfGbd0OfVfMbgTTFo") // Replace with your actual API key

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
