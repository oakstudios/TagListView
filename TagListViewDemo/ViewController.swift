//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.textFont = UIFont.systemFontOfSize(17.0)
        tagListView.selectedBorderColor = UIColor(red: 70/255, green: 222/255, blue: 220/255, alpha: 0.8)
        tagListView.tagSelectedBackgroundColor = UIColor(red: 70/255, green: 222/255, blue: 220/255, alpha: 0.3)
        
        tagListView.addTag("TagListView")
        tagListView.addTag("Is")
        tagListView.addTag("Super")
        tagListView.addTag("Cool")
        tagListView.addTag("Beautiful")
        tagListView.addTag("Uno")
        tagListView.addTag("Dos")
        tagListView.addTag("Quark Shell")
        tagListView.addTag("Keep it going")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let locationPoint = touches.first?.locationInView(self.view),
            let hitView = view.hitTest(locationPoint, withEvent: event) where hitView == self.view
        {
            tagListView.resignFirstResponder()
        }
    }
    
    @IBAction func printValues(sender: AnyObject) {
        print(tagListView.tagValues())
    }
}
