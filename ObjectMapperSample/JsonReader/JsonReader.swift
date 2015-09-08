//
//  JsonReader.swift
//
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

class JsonReader {

    class Task {

        var filePath: String?
        init(filePath _filePath: String) {
            let bundle = NSBundle.mainBundle()
            filePath = bundle.pathForResource(_filePath, ofType: "json")
        }

        internal func resume(completionHandler: (result: [String: AnyObject]) -> ()) {
            if let filePath = filePath, let fileData = NSData(contentsOfFile: filePath) {
                var error: NSError?
                let result = NSJSONSerialization.JSONObjectWithData(fileData, options: .AllowFragments, error: &error) as? [String: AnyObject]

                if let result = result {
                    completionHandler(result: result)
                    return
                }
            }
            completionHandler(result: [String: AnyObject]())
        }
    }

    class func task(filePath: String) -> Task {
        return Task(filePath: filePath)
    }
}