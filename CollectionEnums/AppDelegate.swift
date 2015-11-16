//
//  AppDelegate.swift
//  CollectionEnums
//
//  Created by Ariel Elkin on 16/11/15.
//  Copyright © 2015 Ariel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

