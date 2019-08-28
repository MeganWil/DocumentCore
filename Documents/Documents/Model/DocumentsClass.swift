//
//  DocumentsClass.swift
//  Documents
//
//  Created by Megan Wilson on 8/27/19.
//  Copyright © 2019 Megan Wilson. All rights reserved.
//

import Foundation

class Documents{
    
    class func get() -> [Document] {
        
        var documents = [Document]()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        if let urls = try? FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil){
            for url in urls{
                let name = url.lastPathComponent
                    if let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
                        let size = attributes[FileAttributeKey.size] as? UInt32,
                            let modDate = attributes[FileAttributeKey.modificationDate] as? Date {
                                documents.append(Document(url: url, name: name, size: size, modDate: modDate))
                            }
            }
        }
        return documents
    }
    
    class func delete(url:URL) {
        try? FileManager.default.removeItem(at: url)
    }
    
    class func save(name: String, content: String){
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsURL.appendingPathComponent(name)
        try? content.write(to: url, atomically: true, encoding: .utf8)
    }
}
