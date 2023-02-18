//
//  ViewController.swift
//  NativeApp
//
//  Created by User on 17/02/23.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    var flutterRoute = "/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter1), for: .touchUpInside)
        button.setTitle("Show Flutter1!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
        
        // Make a button to call the showFlutter function when pressed.
        let button2 = UIButton(type:UIButton.ButtonType.custom)
        button2.addTarget(self, action: #selector(showFlutter2), for: .touchUpInside)
        button2.setTitle("Show Flutter2!", for: UIControl.State.normal)
        button2.frame = CGRect(x: 80.0, y: 260, width: 160.0, height: 40.0)
        button2.backgroundColor = UIColor.red
        self.view.addSubview(button2)
    }
    
    // getFlutterViewController
    func getViewController() -> FlutterViewController {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        return flutterViewController
    }
    
    @objc func showFlutter1() {
        self.flutterRoute = "/route1"
        self.configFlutterRoute()
        let flutterViewController = getViewController()
        present(flutterViewController, animated: true, completion: nil)
    }
    
    @objc func showFlutter2() {
        self.flutterRoute = "/route2"
        self.configFlutterRoute()
        let flutterViewController = getViewController()
        
        present(flutterViewController, animated: true, completion: nil)
    }
    
    @objc func configFlutterRoute() {
        let flutterViewController =
        getViewController()

        // make methodchannel
        let flutterChannel = FlutterMethodChannel(name: "com.flutter.modules",
                                                  binaryMessenger: flutterViewController.binaryMessenger)
        flutterChannel.invokeMethod("changeRoute", arguments: self.flutterRoute)

    }
}
