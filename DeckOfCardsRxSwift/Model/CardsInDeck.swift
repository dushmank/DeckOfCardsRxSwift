//
//  CardsInDeck.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/29/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation

// Model for drawing cards in a deck
struct CardsInDeck: Decodable {
    let remaining: Int
    let deck_id: String
    let success: Bool
    let cards: [Card]    
}
