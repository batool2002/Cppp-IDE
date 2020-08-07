//
//  CDMinimapScrollerView.swift
//  C+++
//
//  Created by 23786 on 2020/8/7.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMinimapScrollerView: NSControl {
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        self.frame.origin.y += event.deltaY
        if self.frame.origin.y <= 0 {
            self.frame.origin.y = 0
        }
        if self.frame.height + self.frame.origin.y >= self.superview!.frame.height {
            self.frame.origin.y = self.superview!.frame.height - self.frame.height
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(white: 0.4, alpha: 0.5).cgColor
        self.setNeedsDisplay()
    }
    
}
