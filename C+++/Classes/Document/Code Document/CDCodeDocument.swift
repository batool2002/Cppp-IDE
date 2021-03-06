//
//  Document.swift
//  C+++
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCodeDocument: NSDocument {
    
    @objc var content = CDDocumentContent(contentString: "")
    var contentViewController: CDMainViewController!
    
    // MARK: - Debug
    var debugTask: Process?
    var debugInputPipe: Pipe?
    var debugger: CDDebugger?
    
    // MARK: - Run
    var runTask: Process?
    
    var latestCompileResult: CDCompileResult?
    
    override var fileURL: URL? {
        didSet {
            
            guard oldValue != fileURL else {
                return
            }
            
            if oldValue != nil {
                GlobalLSPClient?.closeDocument(path: oldValue!.path)
            }
            GlobalLSPClient?.openDocument(path: fileURL!.path, content: self.content.contentString)
            
            let selected = self.contentViewController?.leftSidebarTableView?.selectedRow ?? 0
            self.contentViewController?.leftSidebarTableView?.reloadData()
            self.contentViewController?.leftSidebarTableView?.selectRowIndexes(IndexSet([selected]), byExtendingSelection: false)
            
        }
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    override func defaultDraftName() -> String {
        return "Untitled Code Document"
    }
    
    
    // MARK: - Enablers
    
    // This enables auto save.
    override class var autosavesInPlace: Bool {
        return true
    }
    
    // This enables asynchronous-writing.
    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
        return true
    }
    
    // This enables asynchronous reading.
    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {
        return ofType == "public.plain-text"
    }
    
    // MARK: - User Interface
    
    override func makeWindowControllers() {
        
        self.addWindowController(GlobalMainWindowController)
        self.contentViewController = GlobalMainWindowController.contentViewController as? CDMainViewController
        
    }
    
    
    // MARK: - Reading and Writing
    
    override func read(from data: Data, ofType typeName: String) throws {
        content.read(from: data)
    }
    
    override func data(ofType typeName: String) throws -> Data {
        return content.data()!
    }
    
    override func close() {
        super.close()
        
        if self.fileURL != nil {
            GlobalLSPClient?.closeDocument(path: self.fileURL!.path)
        }
        
    }
    
    
    // MARK: - Printing
    
    func thePrintInfo() -> NSPrintInfo {
        let thePrintInfo = NSPrintInfo()
        thePrintInfo.horizontalPagination = .fit
        thePrintInfo.isHorizontallyCentered = false
        thePrintInfo.isVerticallyCentered = false
        
        // One inch margin all the way around.
        thePrintInfo.leftMargin = 72.0
        thePrintInfo.rightMargin = 72.0
        thePrintInfo.topMargin = 72.0
        thePrintInfo.bottomMargin = 72.0
        
        printInfo.dictionary().setObject(NSNumber(value: true),
                                         forKey: NSPrintInfo.AttributeKey.headerAndFooter as NSCopying)
        
        return thePrintInfo
    }
    
    @objc
    func printOperationDidRun(
        _ printOperation: NSPrintOperation, success: Bool, contextInfo: UnsafeMutableRawPointer?) {
        // Printing finished...
    }
    
    @IBAction override func printDocument(_ sender: Any?) {
        // Print the NSTextView.
        
        // Create a copy to manipulate for printing.
        let pageSize = NSSize(width: (printInfo.paperSize.width), height: (printInfo.paperSize.height))
        let textView = NSTextView(frame: NSRect(x: 0.0, y: 0.0, width: pageSize.width, height: pageSize.height))
        
        // Make sure we print on a white background.
        textView.appearance = NSAppearance(named: .aqua)
        
        // Copy the attributed string.
        textView.textStorage?.append(NSAttributedString(string: content.contentString))
        
        let printOperation = NSPrintOperation(view: textView)
        printOperation.runModal(
            for: windowControllers[0].window!,
            delegate: self,
            didRun: #selector(printOperationDidRun(_:success:contextInfo:)), contextInfo: nil)
        
    }
    
    @IBAction func stopCurrentRunningProcess(_ sender: Any?) {
        if debugTask?.isRunning ?? false {
            endDebugging()
        }
        if runTask?.isRunning ?? false {
            runTask?.terminate()
        }
    }
    
    @IBAction func astyle(_ sender: Any?) {
        
        CDAstyleHelper.astyleFile(code: self.content.contentString) {
            (res, success) in
            
            guard success else {
                DispatchQueue.main.async {
                    self.contentViewController.showAlert("Astyle Failed.", "");
                }
                return
            }
            
            DispatchQueue.main.async {
                self.contentViewController.mainTextView.textView.insertText(res!, replacementRange: NSMakeRange(0, self.contentViewController.mainTextView.text.count))
                self.contentViewController.mainTextView.textView.selectAll(nil)
            }
            
        }
        
    }
    
}
