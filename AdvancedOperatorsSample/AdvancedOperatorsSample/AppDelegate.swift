//
//  AppDelegate.swift
//  AdvancedOperatorsSample
//
//  Created by Hirohisa Kawasaki on 6/14/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        runAdvancedOperators()

        return true
    }


    func runAdvancedOperators() {
        let a = Person("a", 50)
        let b = Person("b", 60)
        let c = Person("c", 50)

        let people = a <- b <- c
        println(people)
    }

}

