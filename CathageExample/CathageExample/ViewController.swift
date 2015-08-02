//
//  ViewController.swift
//  CathageExample
//
//  Created by Hirohisa Kawasaki on 7/27/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import PageController

import PageController

class ViewController: PageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = createViewControllers()
    }

    func createViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()

        let names = [
            "favorites",
            "recents",
            "contacts",
            "history",
            "more",
        ]

        for name in names {
            let viewController = UIViewController()
            viewController.title = name
            viewControllers.append(viewController)
        }

        return viewControllers
    }
}