//
//  DocumentStruct.swift
//  Documents
//
//  Created by Megan Wilson on 8/27/19.
//  Copyright © 2019 Megan Wilson. All rights reserved.
//

import Foundation

struct Document {
    let url: URL
    let name: String
    let size: UInt32
    let modDate: Date
    
    var content: String? {
        get{
            return try? String(contentsOf: url, encoding: .utf8)
        }
    }
}


