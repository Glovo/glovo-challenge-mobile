//
//  AppDelegate.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        defer { window.makeKeyAndVisible() }
        
        guard NSClassFromString("XCTest") == nil else {
            window.rootViewController = UIViewController()
            return true
        }
        
        configureFrameworks()
        
        router = Router(with: window)
        router?.start()

        return true
    }
    
    private func configureFrameworks() {
        GMSServices.provideAPIKey(Constants.GoogleMaps.apiKey)
    }

}

