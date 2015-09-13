//
//  Interface.swift
//  RetrofitInterfaceLikeSample
//
//  Created by Hirohisa Kawasaki on 9/12/15.
//  Copyright © 2015 Hirohisa Kawasaki. All rights reserved.
//

import Foundation


protocol Response {
    typealias ResponseTree
    static func decode(result: AnyObject) -> ResponseTree
}

struct IntResponse: Response {

    typealias ResponseTree = (ints: [Int], count: Int)
    static func decode(result: AnyObject) -> ResponseTree {
        return (ints: [1], count: 1)
    }
}

// MARK:- Request
class Request<T: Response> {
    typealias ResponseClosure = T.ResponseTree -> Void

    func resume(closure: ResponseClosure) {
        let value: AnyObject = ["value": 0]
        closure(T.decode(value))
    }
}


class Provider {

    func fetch(completion: [Double] -> Void) {
        Request<IntResponse>().resume { response in
            print(response.ints)
            print(response.count)
            completion([0])
        }
    }
}