//
//  CardsViewModel.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit


struct CardViewModel {
    
    let suit: String
    let value: String
    let image: String
    let code: String
    
    init(card: Card) {
        self.suit = card.suit
        self.value = card.value
        self.image = card.image
        self.code = card.code
    }
}

struct SectionViewModel {
    let section: String
    let color: UIColor
    
    init(section: Section) {
        self.section = section.section
        self.color = section.color
    }
}

struct CardImageModel {
    let image: UIImage
    let url: String
    let value: String
    let suit: String
    
    init(cardImage: CardImage) {
        self.image = cardImage.image
        self.url = cardImage.url
        self.suit = cardImage.suit
        self.value = cardImage.value
    }
}
