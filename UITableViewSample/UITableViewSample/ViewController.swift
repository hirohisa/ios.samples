//
//  ViewController.swift
//  UITableViewSample
//
//  Created by Hirohisa Kawasaki on 5/22/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
    }

    func registerCells() {
        let klasses: [AnyClass] = [
            TableViewCell.self,
        ]

        for klass in klasses {
            let nibName = split(reflect(klass).summary) { $0 == "." }.last!
            tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reflect(klass).summary)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reflect(TableViewCell).summary, forIndexPath: indexPath) as! TableViewCell
        cell.textLabel?.text = "indexPath section:\(indexPath.section), row:\(indexPath.row)"

        return cell
    }
}

