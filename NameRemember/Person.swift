//
//  Person.swift
//  NameRemember
//
//  Created by Matej Kuprešak on 23.08.2023..
//

import Foundation
import SwiftUI

struct Person: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var name: String
    var imageData: Data?
    
    static let example = Person(id: UUID(), name: "Unknown Name", imageData: nil)
}
