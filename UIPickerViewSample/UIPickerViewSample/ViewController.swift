//
//  ViewController.swift
//  UIPickerViewSample
//
//  Created by Hirohisa Kawasaki on 5/13/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        button.addTarget(self, action: "show", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func show() {
        let frame = CGRect(x: 100, y: 100, width: 100, height: 200)
        let pickerView = UIPickerView(frame: frame)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.lightGrayColor()

        view.addSubview(pickerView)
    }

}


extension ViewController: UIPickerViewDataSource {

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

}

extension ViewController: UIPickerViewDelegate {
    //optional func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    //optional func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat

    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {

        return "\(component)"
    }

    //optional func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attributed title is favored if both methods are implemented
    //optional func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView

    //optional func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)

}
