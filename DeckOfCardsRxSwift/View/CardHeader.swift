//
//  CardHeader.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/29/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit


class CardHeader: UITableViewHeaderFooterView {
    
    var sectionViewModel: SectionViewModel {
        didSet {
            section.text = sectionViewModel.section
            bgview.backgroundColor = sectionViewModel.color.withAlphaComponent(0.8)
        }
    }
    
    
    let section: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        label.textColor = UIColor.white
        label.text = "Section"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bgview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        sectionViewModel = SectionViewModel(section: Section(section: String(), color: UIColor()))
        super.init(reuseIdentifier: reuseIdentifier)
        
        addViews()
    }
    
    func addViews(){
        
        contentView.addSubview(section)
        backgroundView = bgview

        let sectionLeft = NSLayoutConstraint(item: section, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10.0)
        let sectionRight = NSLayoutConstraint(item: section, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10.0)
        let sectionTop = NSLayoutConstraint(item: section, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5.0)
        let sectionBottom = NSLayoutConstraint(item: section, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        NSLayoutConstraint.activate([sectionLeft, sectionRight, sectionTop, sectionBottom])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
