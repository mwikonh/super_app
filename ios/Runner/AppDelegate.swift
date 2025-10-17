import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller = (window?.rootViewController as! FlutterViewController)
    let methodChannel = FlutterMethodChannel(name: "DIALOG", binaryMessenger: controller.binaryMessenger)
    
    methodChannel.setMethodCallHandler({[weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if(call.method == "showDialog"){
        let message = call.arguments as! String
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Hello", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
      }
      
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
