//
//  CpppProject.swift
//  C+++
//
//  Created by 23786 on 2020/5/11.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//
//  The project function is cancelled because OIers don't need to build projects.

/*
import Cocoa

class CDProjectDocument: NSDocument {
    
    var project: CDProject!
    var contentViewController: CDProjectMainViewController!
    var contentWindowController: CDProjectMainWindowController!
    var documents = [NSDocument]()
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
        encoder.outputFormatting = .prettyPrinted
        self.project = CDProject(compileCommand: "Not set", version: "1.0")
    }
    
    override func defaultDraftName() -> String {
        return "Untitled C+++ Project"
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
        
        GlobalLaunchViewController.view.window?.close()
        
        let storyboard = NSStoryboard(name: "Project", bundle: nil)
        if let windowController = storyboard.instantiateController(withIdentifier: "Project Window Controller") as? NSWindowController {
            
            self.addWindowController(windowController)
            self.contentWindowController = windowController as? CDProjectMainWindowController
            
            if let vc = windowController.contentViewController as? CDProjectMainViewController {
                vc.document = self
                self.contentViewController = vc
            }
            
        }
        
        

    }
    
    override func save(_ sender: Any?) {
        super.save(sender)
        
        NSLog("Saving Project...")
        let document = self.contentWindowController.document as? CDCodeDocument
        document?.save(sender)
        
    }
    
    
    
    // MARK: - Reading and Writing
    
    override func read(from data: Data, ofType typeName: String) throws {
        
        let result = try decoder.decode(CDProject.self, from: data)
        self.project = result
        
    }
    
    override func data(ofType typeName: String) throws -> Data {
        
        return try encoder.encode(self.project)
        
    }
    
    /*override func runModalSavePanel(for saveOperation: NSDocument.SaveOperationType,
                                         delegate: Any?,
                                          didSave didSaveSelector: Selector?,
                                          contextInfo: UnsafeMutableRawPointer?) {
        super.runModalSavePanel(for: saveOperation, delegate: delegate, didSave: #selector(didSave), contextInfo: contextInfo)
    }
    
    @objc func didSave() {
        if let filePath = fileURL?.path {
            let path = filePath.nsString.deletingLastPathComponent.nsString.appendingPathComponent("main.cpp")
            let anotherPath = path.nsString.deletingLastPathComponent.nsString.appendingPathComponent("main.h")
            FileManager.default.createFile(atPath: path, contents: "#include <cstdio>\nint main() {\n\treturn 0;\n}\n".data(using: .utf8), attributes: nil)
            FileManager.default.createFile(atPath: anotherPath, contents: "#ifndef MAIN_H\n#define MAIN_H\n\n#endif\n".data(using: .utf8), attributes: nil)
            self.project.children.append(.document(CDProject.Document(path: path)))
            self.project.children.append(.document(CDProject.Document(path: anotherPath)))
            self.save(self)
        }
    }*/
    
    @IBAction func cleanBuildFolder(_ sender: Any?) {
        do {
            try FileManager.default.removeItem(at: self.fileURL!.deletingLastPathComponent().appendingPathComponent("Build"))
            self.contentViewController.showAlert("Clean Build Folder Finished.", "")
        } catch {
            self.contentViewController.showAlert("Error", "Unable to clean build folder.")
        }
    }
    
    @IBAction func showInFinder(_ sender: Any?) {
        NSWorkspace.shared.selectFile(self.fileURL!.deletingLastPathComponent().path, inFileViewerRootedAtPath: "")
    }
    
}
*/
