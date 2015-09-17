//
//  ViewController.swift
//  AlamofileSample
//
//  Created by Hirohisa Kawasaki on 9/17/15.
//  Copyright © 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let test = "test".dataUsingEncoding(NSUTF8StringEncoding)!
        let image = UIImage(named: "image.jpg")!
        let data1 = UIImageJPEGRepresentation(image, 0.1)!

        let URL = NSBundle.mainBundle().URLForResource("image", withExtension: "jpg")!

        Alamofire.upload(
            .POST,
            "https://httpbin.org/post",
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: test, name: "test")
                multipartFormData.appendBodyPart(data: data1, name: "test1")
                multipartFormData.appendBodyPart(fileURL: URL, name: "test2")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { request, response, result in
                        debugPrint(result)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

