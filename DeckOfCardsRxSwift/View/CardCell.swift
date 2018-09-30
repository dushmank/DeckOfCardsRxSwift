//
//  CardsCell.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {

    var cardViewModel: CardViewModel {
        didSet {
            cardValue.text = cardViewModel.value.lowercased().capFirst()
            selectedbgview.backgroundColor = magmaOrange.withAlphaComponent(0.6)
            accessoryType = .disclosureIndicator
        }
    }
    
    var cardImageModel: CardImageModel? {
        didSet {
            cardImage.image = cardImageModel?.image
        }
    }
    
    let cardValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textColor = UIColor.black
        label.text = "Ace"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let selectedbgview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        cardViewModel = CardViewModel(card: Card(suit: String(), value: String(), image: String(), code: String()))
        cardImageModel = CardImageModel(cardImage: CardImage(image: UIImage(), url: String(), value: String(), suit: String()))
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addViews()

    }

    func addViews(){
        backgroundColor = UIColor.white
        selectedBackgroundView = selectedbgview
        
        contentView.addSubview(cardImage)
        contentView.addSubview(cardValue)

        let cardImageLeft = NSLayoutConstraint(item: cardImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10.0)
        let cardImageTop = NSLayoutConstraint(item: cardImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5.0)
        let cardImageBottom = NSLayoutConstraint(item: cardImage, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        let cardImageWidth = cardImage.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.15)
        NSLayoutConstraint.activate([cardImageLeft, cardImageTop, cardImageWidth, cardImageBottom])
        
        let cardValueLeft = NSLayoutConstraint(item: cardValue, attribute: .left, relatedBy: .equal, toItem: cardImage, attribute: .right, multiplier: 1.0, constant: 10.0)
        let cardValueRight = NSLayoutConstraint(item: cardValue, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10.0)
        let cardValueTop = NSLayoutConstraint(item: cardValue, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5.0)
        let cardValueBottom = NSLayoutConstraint(item: cardValue, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        NSLayoutConstraint.activate([cardValueLeft, cardValueRight, cardValueTop, cardValueBottom])
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
