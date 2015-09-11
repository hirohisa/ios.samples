//
//  RetrofitInterfaceLikeSampleTests.swift
//  RetrofitInterfaceLikeSampleTests
//
//  Created by Hirohisa Kawasaki on 9/12/15.
//  Copyright © 2015 Hirohisa Kawasaki. All rights reserved.
//

import XCTest
@testable import RetrofitInterfaceLikeSample

class RetrofitInterfaceLikeSampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProviderRun() {
        let provider = Provider()
        provider.fetch { response -> Void in
            print(response)
        }
    }

}
