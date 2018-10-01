//
//  PreviewViewController.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PreviewViewController: UIViewController {
    
    //RxSwift Variables
    var cardImageModelRx = Variable(CardImageModel(cardImage: CardImage(image: UIImage(), url: String(), value: String(), suit: String())))
    
    // RxSwift Dispose Bag
    let bag = DisposeBag()
    
    // Intialize the preview controller with the selected card image, suit, value, url
    init(cardImageModel: CardImageModel) {
        self.cardImageModelRx.value = cardImageModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createLayout()
        bindUI()
        addSwipeDown()
    }
    
    // BindUI when the CardImageModel is init
    func bindUI() {
        cardImageModelRx.asObservable()
            .filter { value in
                value.url != String()
            }
            .bind(onNext: { [weak self] value in
                self?.navigationItem.title = "\(value.value.lowercased().capFirst()) of \(value.suit.lowercased().capFirst())"
                if value.suit.lowercased() == "hearts" || value.suit.lowercased() == "diamonds" {
                    self?.navigationController?.navigationBar.barTintColor = .red
                } else {
                    self?.navigationController?.navigationBar.barTintColor = .black
                }
                self?.cardPreviewView.cardPreviewModel = CardPreviewModel(cardPreview: CardPreview(image: value.image))
                
            })
            .disposed(by: bag)
        
        // Dismiss Preview Controller when Done is tapped
        backItem.rx.tap
            .subscribe { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: bag)
        
        // Dismiss Preview Controller when a swipe down is observed
        swipeDown.rx.event
            .subscribe{ [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
    // Customize the navigation bar
    var backItem = UIBarButtonItem()
    func createNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 36)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 24)!]
        backItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backItem
    }
    
    var swipeDown = UISwipeGestureRecognizer()
    func addSwipeDown() {
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    // Create Layout
    let cardPreviewView = CardPreviewView(frame: CGRect())
    
    func createLayout() {
        view.backgroundColor = .white
        
        view.addSubview(cardPreviewView)
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
