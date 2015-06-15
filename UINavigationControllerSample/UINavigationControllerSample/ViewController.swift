//
//  ViewController.swift
//  UINavigationControllerSample
//
//  Created by Hirohisa Kawasaki on 6/11/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var source = split("A,B,C,D,E,F,G,H,I,J,K,L,M,N", isSeparator: { $0 == "," })

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        //navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        let string = source[indexPath.row]
        cell.textLabel?.text = string

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let viewController = ViewController()
        navigationController?.showViewController(viewController, sender: navigationController!)
    }
}

