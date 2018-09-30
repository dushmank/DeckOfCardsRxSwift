//
//  Cards.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation

// Model for individual cards in a deck
struct Card: Decodable {
    let suit: String
    let value: String
    let image: String
    let code: String
    
}
