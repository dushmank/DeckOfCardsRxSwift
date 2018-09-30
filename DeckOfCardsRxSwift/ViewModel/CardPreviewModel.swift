//
//  CardPreviewModel.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/30/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit


struct CardPreviewModel {

    let image: UIImage

    init(cardPreview: CardPreview) {
        self.image = cardPreview.image
    }
}
