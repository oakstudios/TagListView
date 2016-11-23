//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        tagListView.textFont = UIFont.systemFontOfSize(17.0)
        tagListView.selectedBorderColor = UIColor(red: 70/255, green: 222/255, blue: 220/255, alpha: 0.8)
        tagListView.tagSelectedBackgroundColor = UIColor(red: 70/255, green: 222/255, blue: 220/255, alpha: 0.3)
        
        tagListView.addTag("Lorem")
        tagListView.addTag("ipsum")
        tagListView.addTag("dolor")
        tagListView.addTag("sit")
        tagListView.addTag("amet")
        tagListView.addTag("consectetur")
        tagListView.addTag("adipiscing")
        tagListView.addTag("elit")
        tagListView.addTag("Duis vitae")
        tagListView.addTag("nulla")
        tagListView.addTag("diam")
        tagListView.addTag("Vestibulum")
        tagListView.addTag("Nunc fringilla")
        tagListView.addTag("justo")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let locationPoint = touches.first?.locationInView(self.view),
            let hitView = view.hitTest(locationPoint, withEvent: event) where hitView == self.view
        {
            tagListView.resignFirstResponder()
        }
    }
    
    func valuesDidChange(sender: TagListView) {
        print("Values did change: \(sender.tagValues())")
    }
}
