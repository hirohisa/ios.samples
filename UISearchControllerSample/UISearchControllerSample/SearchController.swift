//
//  SearchController.swift
//  SearchControllerSample
//
//  Created by Hirohisa Kawasaki on 5/13/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class SearchResultController: UITableViewController {

    var result = split("D,E,F,L,M,N", isSeparator: { $0 == "," })

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = result[indexPath.row]

        return cell
    }

    func reloadData() {
        tableView.reloadData()
    }

}

class SearchController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {

    var source = split("A,B,C,D,E,F,G,H,I,J,K,L,M,N", isSeparator: { $0 == "," })
    var filtered = split("D,E,F,L,M,N", isSeparator: { $0 == "," })

    var result: [String] {
        if searchController.active {
            return filtered
        } else {
            return source
        }
    }

    var searchController: UISearchController!
    let resultController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        searchController = UISearchController(searchResultsController: nil)
        //searchController = UISearchController(searchResultsController: UINavigationController(rootViewController: resultController))

        let frame = navigationController!.navigationBar.frame
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        if indexPath.row < result.count {
            cell.textLabel?.text = result[indexPath.row]
        }

        return cell
    }

    func reloadData() {
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        reloadData()
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func willPresentSearchController(searchController: UISearchController) {
        println("will present")
    }
    func didPresentSearchController(searchController: UISearchController) {
        println("did present")
    }

    func willDismissSearchController(searchController: UISearchController) {
        println("will dismiss")
    }

    func didDismissSearchController(searchController: UISearchController) {
        println("did dismiss")
    }
    
    func presentSearchController(searchController: UISearchController) {
        println("present")
    }
    
}
