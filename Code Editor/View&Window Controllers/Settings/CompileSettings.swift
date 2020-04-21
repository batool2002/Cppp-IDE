//
//  CompileSettings.swift
//  Code Editor
//
//  Created by apple on 2020/4/17.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CompileSettings: NSObject, NSCoding {
    
    var Compiler: String!
    var Arguments: String!
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("CompileSettings")
    
    struct PropertyKey {
        static let Compiler = "Compiler"
        static let Arguments = "Arguments"
    }
    
    init?(_ compiler: String?, _ arguments: String?) {
        self.Compiler = compiler
        self.Arguments = arguments
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(Compiler, forKey: PropertyKey.Compiler)
        coder.encode(Arguments, forKey: PropertyKey.Arguments)
    }
    
    required convenience init?(coder: NSCoder) {
        let compiler = coder.decodeObject(forKey: PropertyKey.Compiler) as? String
        let arguments = coder.decodeObject(forKey: PropertyKey.Arguments) as? String
        
        self.init(compiler, arguments)
    }
    
}