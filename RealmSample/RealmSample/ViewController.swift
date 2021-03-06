//
//  ViewController.swift
//  RealmSample
//
//  Created by Hirohisa Kawasaki on 5/27/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import RealmSwift


class Person: Object {

    dynamic var name = ""
    dynamic var age: Int = 0
    dynamic var createdAt: Double = 0
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        dispatch_async(dispatch_get_main_queue()) {
            self.runRealmOnMainThread()
        }

        let concurrent_queue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT)
        let serial_queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL)

        let delay1 = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
        let delay2 = dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC)))
        dispatch_after(delay1, concurrent_queue) {
            self.readDataFromRealm()
        }
        dispatch_after(delay2, serial_queue) {
            self.readDataFromRealm()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func runRealmOnMainThread() {
        let realm = Realm()

        let people = testPeople()
        realm.write {
            for person in people {
                realm.add(person)
            }
        }

        let result = realm.objects(Person)

        if NSThread.isMainThread() {
            println("main thread")
        }

        println("default") // => 3 A B C
        println(result.count)
        for person in result {
            println(person.name)
        }

        println("filter") // => 2 B C
        println(result.count)
        for person in result.filter("age > 2") {
            println(person.name)
        }

        println("sorting desc by createdAt") // => 3 C B A
        println(result.count)
        for person in result.sorted("createdAt", ascending: false) {
            println(person.name)
        }


        // Exception 'Realm accessed from incorrect thread'
        /*
        let queue = dispatch_queue_create("other", DISPATCH_QUEUE_CONCURRENT)
        dispatch_async(queue) {

            println("access from other thread")
            println(result.count)
            for person in result {
                println(person.name)
            }
        }
        */
    }

    func readDataFromRealm() {
        println("readData")
        if NSThread.isMainThread() {
            println("main thread")
        }
        let realm = Realm()
        let result = realm.objects(Person)
        println(result.count)
        for person in result {
            println(person.name)
        }
    }

    func setup() {

        NSFileManager.defaultManager().removeItemAtPath(Realm.defaultPath, error: nil)
    }

    func testPeople() -> [Person] {

        let p1 = Person()
        p1.name = "A"
        p1.age = 2
        p1.createdAt = NSDate().timeIntervalSince1970

        let p2 = Person()
        p2.name = "B"
        p2.age = 10
        p2.createdAt = NSDate().timeIntervalSince1970

        let p3 = Person()
        p3.name = "C"
        p3.age = 12
        p3.createdAt = NSDate().timeIntervalSince1970

        return [p1, p2, p3]
    }
}

