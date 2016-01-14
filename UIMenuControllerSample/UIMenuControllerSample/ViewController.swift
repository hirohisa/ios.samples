//
//  ViewController.swift
//  UIMenuControllerSample
//
//  Created by Hirohisa Kawasaki on 12/17/15.
//  Copyright © 2015 Hirohisa. All rights reserved.
//

import UIKit

class Label: UILabel {

    var gestureRecognizer: UILongPressGestureRecognizer! {
        didSet {
            addGestureRecognizer(gestureRecognizer)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        userInteractionEnabled = true
        gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
    }

    func longPressed(sender: AnyObject?) {
        if gestureRecognizer.state != .Began {
            return
        }

        becomeFirstResponder()

        let menuController = UIMenuController.sharedMenuController()
        let rect = CGRect(x: bounds.minX, y: bounds.midY, width: bounds.width, height: 0)
        menuController.setTargetRect(rect, inView: self)
        menuController.setMenuVisible(true, animated: true)
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func resignFirstResponder() -> Bool {
        let menuController = UIMenuController.sharedMenuController()
        menuController.setMenuVisible(false, animated: false)
        return true
    }
}

class Cell: UITableViewCell {
    @IBOutlet weak var mainLabel: Label!
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        print(action)

        return true
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}