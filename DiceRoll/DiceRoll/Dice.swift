//
//  Dice.swift
//  DiceRoll
//
//  Created by Matej Kuprešak on 05.09.2023..
//

import Foundation

class Dice: ObservableObject {
    let id = UUID() 

    @Published var type = 4
    @Published var number = 3
    
    init() {}
}
