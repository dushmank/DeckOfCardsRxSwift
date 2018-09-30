//
//  InitialViewController.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/28/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cards = [CardViewModel]()
    var diamonds = [CardViewModel]()
    var clubs = [CardViewModel]()
    var hearts = [CardViewModel]()
    var spades = [CardViewModel]()
    var sections = [SectionViewModel]()
    var cardImages = Dictionary<String, CardImageModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createLayout()
        drawCards()
        
        sections.append(SectionViewModel(section: Section(section: "Diamonds", color: .red)))
        sections.append(SectionViewModel(section: Section(section: "Clubs", color: .black)))
        sections.append(SectionViewModel(section: Section(section: "Hearts", color: .red)))
        sections.append(SectionViewModel(section: Section(section: "Spades", color: .black)))
                
    }
    // Draw all 52 cards from the shuffled deck, sort them by suit, then start downloading the card images
    func drawCards() {
        
        DeckOfCardsApi.shared.drawCards(deckid: deck_id) { (cardsData, error) in
            if let error = error {
                print("Error drawing cards", error)
                return
            }
            
            let sortedCards = DeckOfCardsApi.shared.sortCards(cards: cardsData!.cards)
            
            self.diamonds = sortedCards.diamond.map({return CardViewModel(card: $0)})
            self.clubs = sortedCards.club.map({return CardViewModel(card: $0)})
            self.hearts = sortedCards.heart.map({return CardViewModel(card: $0)})
            self.spades = sortedCards.spade.map({return CardViewModel(card: $0)})
            
            // Move Ace to the top
            let diamondsAce = self.diamonds.remove(at: 9)
            self.diamonds.insert(diamondsAce, at: 0)
            let clubsAce = self.clubs.remove(at: 9)
            self.clubs.insert(clubsAce, at: 0)
            let heartsAce = self.hearts.remove(at: 9)
            self.hearts.insert(heartsAce, at: 0)
            let spadesAce = self.spades.remove(at: 9)
            self.spades.insert(spadesAce, at: 0)
            
            // Move king to the bottom
            let diamondsKing = self.diamonds.remove(at: 11)
            self.diamonds.insert(diamondsKing, at: 12)
            let clubsKing = self.clubs.remove(at: 11)
            self.clubs.insert(clubsKing, at: 12)
            let heartsKing = self.hearts.remove(at: 11)
            self.hearts.insert(heartsKing, at: 12)
            let spadesKing = self.spades.remove(at: 11)
            self.spades.insert(spadesKing, at: 12)
            
            self.cardsTableView.reloadData()
            
            // Download Card Images
            self.downloadCards()
        }
    }
    
    // Download card images from each suit
    func downloadCards() {
        let suits = [self.diamonds, self.clubs, self.hearts, self.spades]
        for i in 0..<suits.count {
            let singleSuit = suits[i]
            for j in 0..<singleSuit.count {
                let singleCard = singleSuit[j]
                DeckOfCardsApi.shared.downloadCard(cardUrl: singleCard.image, value: singleCard.value, suit: singleCard.suit, completion: { (cardimage, error) in
                    if let error = error {
                        print("Error downloading cards", error)
                        return
                    }
                    DispatchQueue.main.async(execute: {
                        self.cardImages["\(cardimage!.url)"] = CardImageModel(cardImage: cardimage!)
                        self.cardsTableView.reloadData()
                    })
                })
            }
        }
    }

    // Create the navigation bar
    func createNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Deck of Cards"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = magmaOrange
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 36)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: ".SFUIDisplay-Bold", size: 24)!]
    }
    
    
    // Create the layout of the view
    let cardsTableView = UITableView()
    let cardsCellId = "CardsCell"
    let cardsHeaderId = "CardsHeader"
    
    func createLayout() {
        view.backgroundColor = .white
        
        cardsTableView.backgroundColor = .white
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.register(CardCell.self, forCellReuseIdentifier: cardsCellId)
        cardsTableView.register(CardHeader.self, forHeaderFooterViewReuseIdentifier: cardsHeaderId)
        view.addSubview(cardsTableView)
        let tableViewLeft = NSLayoutConstraint(item: cardsTableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let tableViewRight = NSLayoutConstraint(item: cardsTableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0)
        let tableViewTop = NSLayoutConstraint(item: cardsTableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
        let tableViewBottom = NSLayoutConstraint(item: cardsTableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        cardsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableViewLeft, tableViewRight, tableViewTop, tableViewBottom])
    }
    
    
    
    // Table View Protocols
    
    // Custom Header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: cardsHeaderId) as! CardHeader
        header.sectionViewModel = sections[section]
        return header
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    // Number of sections in the tableview, one for each suit
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Number of items in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return diamonds.count
        } else if section == 1 {
            return clubs.count
        } else if section == 2 {
            return hearts.count
        } else {
            return spades.count
        }
    }
    
    // Cell pulls views from CellViewModel and CellImageModel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cardsCellId, for: indexPath) as! CardCell
        
        if indexPath.section == 0 {
            cell.cardViewModel = diamonds[indexPath.row]
            cell.cardImageModel = cardImages["\(diamonds[indexPath.row].image)"]
        } else if indexPath.section == 1 {
            cell.cardViewModel = clubs[indexPath.row]
            cell.cardImageModel = cardImages["\(clubs[indexPath.row].image)"]
        } else if indexPath.section == 2 {
            cell.cardViewModel = hearts[indexPath.row]
            cell.cardImageModel = cardImages["\(hearts[indexPath.row].image)"]
        } else {
            cell.cardViewModel = spades[indexPath.row]
            cell.cardImageModel = cardImages["\(spades[indexPath.row].image)"]
        }
        return cell
    }
    
    // Height of the row, based on width of the device to keep an aspect ratio with the image height/width
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width*0.2
    }
    
    // Upon selecting a row, preview the CardImage modally and deselect the row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        
        var cardImageModel: CardImageModel?
        
        if section == 0 {
            cardImageModel = cardImages["\(self.diamonds[indexPath.row].image)"]
        } else if section == 1 {
            cardImageModel = cardImages["\(self.clubs[indexPath.row].image)"]
        } else if section == 2 {
            cardImageModel = cardImages["\(self.hearts[indexPath.row].image)"]
        } else {
            cardImageModel = cardImages["\(self.spades[indexPath.row].image)"]
        }
        
        // present previewViewController
        let navController = UINavigationController(rootViewController: PreviewViewController(cardImageModel: cardImageModel!))
        self.present(navController, animated: true, completion: nil)

    }
    
    


}
