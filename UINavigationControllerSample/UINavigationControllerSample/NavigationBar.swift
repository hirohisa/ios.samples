//
//  NavigationBar.swift
//  UINavigationControllerSample
//
//  Created by Hirohisa Kawasaki on 6/20/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    // if self is gone then call `setItems(items:animated:)`
    /*
    override func setItems(items: [AnyObject]!, animated: Bool) {
        super.setItems(items, animated: animated)
        println("set items")
        println(items)
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
        println(backItem)

        if needsChangeBackBarButtonItem() {
            changeBackBarButtonItem()
        }
    }

    func needsChangeBackBarButtonItem() -> Bool {
        return topItem?.backBarButtonItem == nil
    }

    func changeBackBarButtonItem() {
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        topItem?.backBarButtonItem = backButtonItem
    }
}