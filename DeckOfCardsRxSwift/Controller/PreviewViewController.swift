//
//  PreviewViewController.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var cardImageModel: CardImageModel
    
    // Intialize the preview controller with the selected card image, suit, value, url
    
    init(cardImageModel: CardImageModel) {
        self.cardImageModel = cardImageModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavBar()
        createLayout()
        addSwipeDown()
    }
    
    // Customize the navigation bar
    
    func createNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "\(cardImageModel.value.lowercased().capFirst()) of \(cardImageModel.suit.lowercased().capFirst())"
        
        if cardImageModel.suit.lowercased() == "hearts" || cardImageModel.suit.lowercased() == "diamonds" {
            self.navigationController?.navigationBar.barTintColor = .red
        } else {
            self.navigationController?.navigationBar.barTintColor = .black
        }
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 36)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 24)!]
        let backItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleBackItem))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backItem
    }
    
    // When the back bar button item is pressed
    
    @objc func handleBackItem() {
        self.dismiss(animated: true) {
            self.cardImageModel = CardImageModel(cardImage: CardImage(image: UIImage(), url: String(), value: String(), suit: String()))
        }
    }
    
    func addSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleBackItem))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
    }
    
    // Create Layout
    let cardPreviewView = CardPreviewView(frame: CGRect())
    
    func createLayout() {
        view.backgroundColor = .white
        
        view.addSubview(cardPreviewView)
        let cardPreviewModel = CardPreviewModel(cardPreview: CardPreview(image: cardImageModel.image))
        cardPreviewView.cardPreviewModel = cardPreviewModel
        let viewLeft = NSLayoutConstraint(item: cardPreviewView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let viewTop = NSLayoutConstraint(item: cardPreviewView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
        let viewBottom = NSLayoutConstraint(item: cardPreviewView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        let viewRight = NSLayoutConstraint(item: cardPreviewView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0)
        cardPreviewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([viewLeft, viewRight, viewTop, viewBottom])
    }
    
}


extension UINavigationController {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// Capitalizing the first letter
extension String {
    func capFirst() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capFirstLetter() {
        self = self.capFirst()
    }
}
