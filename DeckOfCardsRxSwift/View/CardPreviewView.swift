//
//  CardView.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/30/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit

class CardPreviewView: UIView {
    
    var cardPreviewModel: CardPreviewModel {
        didSet {
            cardImage.image = cardPreviewModel.image
        }
    }
    
    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let view1: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        cardPreviewModel = CardPreviewModel(cardPreview: CardPreview(image: UIImage()))
        super.init(frame: frame)
        
        addViews()
    }
    
    func addViews(){
        addSubview(cardImage)
        
        let cardImageLeft = NSLayoutConstraint(item: cardImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        let cardImageTop = NSLayoutConstraint(item: cardImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let cardImageBottom = NSLayoutConstraint(item: cardImage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let cardImageRight = NSLayoutConstraint(item: cardImage, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([cardImageLeft, cardImageTop, cardImageRight, cardImageBottom])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
