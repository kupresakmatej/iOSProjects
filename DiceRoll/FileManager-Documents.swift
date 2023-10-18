//
//  FileManager-Documents.swift
//  DiceRoll
//
//  Created by Matej Kuprešak on 05.09.2023..
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
