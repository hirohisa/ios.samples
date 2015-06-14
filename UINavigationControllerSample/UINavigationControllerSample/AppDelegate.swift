//
//  AppDelegate.swift
//  UINavigationControllerSample
//
//  Created by Hirohisa Kawasaki on 6/11/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // http://stackoverflow.com/questions/19078995/removing-the-title-text-of-an-ios-7-uibarbuttonitem
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: .Default)

        return true
    }
}

