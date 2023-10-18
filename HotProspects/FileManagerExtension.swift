//
//  FileManagerExtension.swift
//  HotProspects
//
//  Created by Matej Kuprešak on 25.08.2023..
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
