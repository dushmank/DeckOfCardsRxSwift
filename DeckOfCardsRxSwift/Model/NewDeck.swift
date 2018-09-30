//
//  NewDeck.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/29/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation

// Model for creating a new deck
struct NewDeck: Decodable {
    let remaining: Int
    let deck_id: String
    let success: Bool
    let shuffled: Bool
}
