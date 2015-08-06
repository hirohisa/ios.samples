//
//  RxSwiftSampleTests.swift
//  RxSwiftSampleTests
//
//  Created by Hirohisa Kawasaki on 8/5/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import XCTest
import RxSwift

class RxSwiftSampleTests: XCTestCase {

    func testCombineLatest() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        let label = UILabel()
        XCTAssertNil(label.text, "label's text is not nil")

        let o = combineLatest(v0, v1) { (a0, a1) in a0 + a1 }
        let d = o >- subscribeNext { result = $0 }
        o >- filter { $0 % 2 != 0 } >- subscribeNext { label.text = "\($0)" }

        XCTAssertEqual(label.text!, "1")
        XCTAssertEqual(result, 1)

        v0.next(2) // 2 + 1
        XCTAssertEqual(label.text!, "3")
        XCTAssertEqual(result, 3)

        v1.next(2) // 2 + 2

        XCTAssertEqual(label.text!, "3")
        XCTAssertEqual(result, 4)

        v0.next(5) // 5 + 2
        v1.next(5) // 5 + 5
        XCTAssertEqual(label.text!, "7")

        XCTAssertEqual(result, 10)

        d.dispose()

        v0.next(1) // 1 + 5
        v1.next(1) // 1 + 1

        XCTAssertEqual(label.text!, "7")
        XCTAssertEqual(result, 10)

    }

    func testZip1() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        zip(v0, v1) { (a0, a1) in a0 + a1 } >- subscribeNext { result = $0 }

        XCTAssertEqual(result, 1)

    }

    func testZip2() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        let o = zip(v0, v1) { (a0, a1) in a0 + a1 }
        let d = o >- subscribeNext { result = $0 }
        o >- subscribeNext { println($0) }

        XCTAssertEqual(result, 1)

        v0.next(2)
        XCTAssertEqual(result, 1)

        v1.next(3)

        XCTAssertEqual(result, 5)

        d.dispose()

        v0.next(1)
        v1.next(1)

        XCTAssertEqual(result, 5)

    }

    func testUseArray() {

        let v0 = Variable([1,2,3])
        let v1 = Variable([1,2,3])

        var result: Int = 0

        let o = combineLatest(v0, v1) { (a0, a1) in a0 + a1 }
        o >- subscribeNext { (array : Array) -> Void in
            result = array.reduce(0) { $0 + $1 }
        }

        XCTAssertEqual(result, 12)

        v0.next([2,3,4])

        XCTAssertEqual(result, 15)


    }

}
