//
//  LaunchScreen.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit

public var magmaOrange = UIColor(red: 241/255, green: 152/255, blue: 32/255, alpha: 1.0)

class LaunchScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDeck()
        createLayout()
        suiteAnimation()
    }
    
    // Create a new deck and return deck id
    func createDeck() {
        DeckOfCardsApi.shared.createDeck()
    }
    
    // Reference to intial view controller
    let navController = UINavigationController(rootViewController: InitialViewController())
        
    // Create the layout of the launch screen view controller
    let diamondsView = UIView()
    let clubsView = UIView()
    let heartsView = UIView()
    let spadesView = UIView()
    
    let diamondsImageView = UIImageView()
    let clubsImageView = UIImageView()
    let heartsImageView = UIImageView()
    let spadesImageView = UIImageView()
    
    func createLayout() {
        view.backgroundColor = .white
        
        let suiteIconSize: CGFloat = 60.0
        
        diamondsView.backgroundColor = .clear
        view.addSubview(diamondsView)
        let diamondsViewLeft = NSLayoutConstraint(item: diamondsView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let diamondsViewBottom = NSLayoutConstraint(item: diamondsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let diamondsViewHeight = diamondsView.heightAnchor.constraint(equalToConstant: suiteIconSize)
        let diamondsViewWidth = diamondsView.widthAnchor.constraint(equalToConstant: suiteIconSize)
        diamondsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([diamondsViewLeft, diamondsViewBottom, diamondsViewHeight, diamondsViewWidth])
        
        diamondsImageView.image = #imageLiteral(resourceName: "diamondsIcon")
        diamondsImageView.contentMode = .scaleAspectFit
        diamondsView.addSubview(diamondsImageView)
        let diamondsImageViewLeft = NSLayoutConstraint(item: diamondsImageView, attribute: .left, relatedBy: .equal, toItem: diamondsView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let diamondsImageViewRight = NSLayoutConstraint(item: diamondsImageView, attribute: .right, relatedBy: .equal, toItem: diamondsView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let diamondsImageViewTop = NSLayoutConstraint(item: diamondsImageView, attribute: .top, relatedBy: .equal, toItem: diamondsView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let diamondsImageViewBottom = NSLayoutConstraint(item: diamondsImageView, attribute: .bottom, relatedBy: .equal, toItem: diamondsView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        diamondsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([diamondsImageViewTop, diamondsImageViewBottom, diamondsImageViewRight, diamondsImageViewLeft])
        
        clubsView.backgroundColor = .clear
        view.addSubview(clubsView)
        let clubsViewRight = NSLayoutConstraint(item: clubsView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let clubsViewBottom = NSLayoutConstraint(item: clubsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let clubsViewHeight = clubsView.heightAnchor.constraint(equalToConstant: suiteIconSize)
        let clubsViewWidth = clubsView.widthAnchor.constraint(equalToConstant: suiteIconSize)
        clubsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([clubsViewRight, clubsViewBottom, clubsViewHeight, clubsViewWidth])
        
        clubsImageView.image = #imageLiteral(resourceName: "clubsIcon")
        clubsImageView.contentMode = .scaleAspectFit
        clubsView.addSubview(clubsImageView)
        let clubsImageViewLeft = NSLayoutConstraint(item: clubsImageView, attribute: .left, relatedBy: .equal, toItem: clubsView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let clubsImageViewRight = NSLayoutConstraint(item: clubsImageView, attribute: .right, relatedBy: .equal, toItem: clubsView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let clubsImageViewTop = NSLayoutConstraint(item: clubsImageView, attribute: .top, relatedBy: .equal, toItem: clubsView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let clubsImageViewBottom = NSLayoutConstraint(item: clubsImageView, attribute: .bottom, relatedBy: .equal, toItem: clubsView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        clubsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([clubsImageViewTop, clubsImageViewBottom, clubsImageViewRight, clubsImageViewLeft])
        
        
        heartsView.backgroundColor = .clear
        view.addSubview(heartsView)
        let heartsViewRight = NSLayoutConstraint(item: heartsView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let heartsViewTop = NSLayoutConstraint(item: heartsView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let heartsViewHeight = heartsView.heightAnchor.constraint(equalToConstant: suiteIconSize)
        let heartsViewWidth = heartsView.widthAnchor.constraint(equalToConstant: suiteIconSize)
        heartsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heartsViewRight, heartsViewTop, heartsViewHeight, heartsViewWidth])
        
        heartsImageView.image = #imageLiteral(resourceName: "heartsIcon")
        heartsImageView.contentMode = .scaleAspectFit
        heartsView.addSubview(heartsImageView)
        let heartsImageViewLeft = NSLayoutConstraint(item: heartsImageView, attribute: .left, relatedBy: .equal, toItem: heartsView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let heartsImageViewRight = NSLayoutConstraint(item: heartsImageView, attribute: .right, relatedBy: .equal, toItem: heartsView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let heartsImageViewTop = NSLayoutConstraint(item: heartsImageView, attribute: .top, relatedBy: .equal, toItem: heartsView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let heartsImageViewBottom = NSLayoutConstraint(item: heartsImageView, attribute: .bottom, relatedBy: .equal, toItem: heartsView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        heartsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heartsImageViewTop, heartsImageViewBottom, heartsImageViewLeft, heartsImageViewRight])
        
        spadesView.backgroundColor = .clear
        view.addSubview(spadesView)
        let spadesViewLeft = NSLayoutConstraint(item: spadesView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let spadesViewTop = NSLayoutConstraint(item: spadesView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let spadesViewHeight = spadesView.heightAnchor.constraint(equalToConstant: suiteIconSize)
        let spadesViewWidth = spadesView.widthAnchor.constraint(equalToConstant: suiteIconSize)
        spadesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spadesViewLeft, spadesViewTop, spadesViewHeight, spadesViewWidth])
        
        spadesImageView.image = #imageLiteral(resourceName: "spadesIcon")
        spadesImageView.contentMode = .scaleAspectFit
        spadesView.addSubview(spadesImageView)
        let spadesImageViewLeft = NSLayoutConstraint(item: spadesImageView, attribute: .left, relatedBy: .equal, toItem: spadesView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let spadesImageViewRight = NSLayoutConstraint(item: spadesImageView, attribute: .right, relatedBy: .equal, toItem: spadesView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let spadesImageViewTop = NSLayoutConstraint(item: spadesImageView, attribute: .top, relatedBy: .equal, toItem: spadesView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let spadesImageViewBottom = NSLayoutConstraint(item: spadesImageView, attribute: .bottom, relatedBy: .equal, toItem: spadesView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        spadesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spadesImageViewTop, spadesImageViewBottom, spadesImageViewLeft, spadesImageViewRight])
    }
    
    // Animate Suites while loading deck
    func suiteAnimation() {
        
        diamondsImageView.alpha = 0.0
        clubsImageView.alpha = 0.0
        heartsImageView.alpha = 0.0
        spadesImageView.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.diamondsImageView.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
            self.clubsImageView.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.4, options: .curveEaseOut, animations: {
            self.heartsImageView.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.6, options: .curveEaseOut, animations: {
            self.spadesImageView.alpha = 1.0
            self.view.backgroundColor = magmaOrange
        }) { (competion) in
            // if deck is loaded, present initial view controller, if not, repeat the animation
            
            if deck_id != "" {
                                
                // Now with the deckID saved, present the intial view controller
                DispatchQueue.main.async(execute: {
                    self.navController.modalTransitionStyle = .coverVertical
                    self.present(self.navController, animated: true, completion: nil)
                })
            } else {
                self.suiteAnimation()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
