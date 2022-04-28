//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Aarish on 29/04/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
