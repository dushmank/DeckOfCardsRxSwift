//
//  CardsInSuit.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/29/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation

// Cards sorted into each suite
struct CardsInSuit: Decodable {
    let diamond: [Card]
    let club: [Card]
    let heart: [Card]
    let spade: [Card]
}
