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

    func testZip1() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        let d = zip(v0, v1) { (a0, a1) in a0 + a1 } >- subscribeNext { result = $0 }

        XCTAssertEqual(result, 1)

    }

    func testZip2() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        let d = zip(v0, v1) { (a0, a1) in a0 + a1 }

        d >- subscribeNext { result = $0 }

        XCTAssertEqual(result, 1)

        v0.next(2)

        XCTAssertEqual(result, 1)

        d >- subscribeNext { result = $0 }

        XCTAssertEqual(result, 3)

    }

}
