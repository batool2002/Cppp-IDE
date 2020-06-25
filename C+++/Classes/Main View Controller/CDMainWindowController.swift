//
//  WindowController.swift
//  Code Editor
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMainWindowController: NSWindowController, NSWindowDelegate {
    
    @objc dynamic var statusString = "C+++ | Ready"
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if #available(OSX 10.14, *) {
            self.window?.appearance = darkAqua
        } else {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.shouldCascadeWindows = true
        
    }
    
    func disableCompiling() {
        
        self.window?.toolbar?.isVisible = false
        
        let vc = (self.contentViewController as! CDMainViewController)
        vc.bottomConstraint.constant = 22.0
        vc.bottom = false
        vc.rightConstraint.constant = 0.0
        vc.right = false
        vc.compileView.isHidden = true
        vc.leftConstraint.constant = 0.0
        vc.left = false
        vc.fileAndSnippetView.isHidden = true
        
    }
    
    @IBAction func toggleCompileInfoViewShown(_ sender: Any) {
        
        let vc = (self.contentViewController as! CDMainViewController)
        if vc.bottom == true {
            vc.bottomConstraint.constant = 22.0
            vc.bottom = false
        } else {
            vc.bottomConstraint.constant = 165.0
            vc.bottom = true
        }
        
    }
    
    @IBAction func toggleCompileViewShown(_ sender: Any) {
        
        let vc = (self.contentViewController as! CDMainViewController)
        if vc.right == true {
            vc.rightConstraint.constant = 0.0
            vc.right = false
            vc.compileView.isHidden = true
        } else {
            vc.rightConstraint.constant = 253.0
            vc.right = true
            vc.compileView.isHidden = false
        }
        
    }
    
    @IBAction func toggleFileViewShown(_ sender: Any) {
        
        let vc = (self.contentViewController as! CDMainViewController)
        if vc.left == true {
            vc.leftConstraint.constant = 0.0
            vc.left = false
            vc.fileAndSnippetView.isHidden = true
        } else {
            vc.leftConstraint.constant = 219.0
            vc.left = true
            vc.fileAndSnippetView.isHidden = false
        }
        
    }
    
}