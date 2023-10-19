//
//  FileManager-Documents.swift
//  SnowSeeker
//
//  Created by Matej Kuprešak on 06.09.2023..
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
