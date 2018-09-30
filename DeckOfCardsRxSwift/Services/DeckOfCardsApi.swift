//
//  Services.swift
//  DeckOfCards
//
//  Created by Kyle Dushman on 9/29/18.
//  Copyright © 2018 Kyle Dushman. All rights reserved.
//

import Foundation
import UIKit

public var deck_id = String()

class DeckOfCardsApi: NSObject {
        static let shared = DeckOfCardsApi()
    
    // Class for KVO, observing a change in deckid
    class Deck: NSObject {
        @objc dynamic var id: String
        override init() {
            id = ""
            super.init()
        }
    }
    
    // Create a deck and save the deckID
    func createDeck() {
        let newDeckUrl = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        let url = URL(string: newDeckUrl)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // KVO Implementation to monitor when deck has been changed
                    let deck = Deck()
                    let observation = deck.observe(\.id, options: .new) { (deck, change) in
                        print("Deck has been found: \(deck.id)")
                        deck_id = deck.id
                    }
                    deck.id = json["deck_id"] as! String
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func drawCards(deckid: String, completion: @escaping (CardsInDeck?, Error?) -> ()) {
        let drawCardsUrl = "https://deckofcardsapi.com/api/deck/\(deckid)/draw/?count=52"
        let url = URL(string: drawCardsUrl)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
        do {
            let cardsindeck = try JSONDecoder().decode(CardsInDeck.self, from: data)
                DispatchQueue.main.async {
                    completion(cardsindeck, nil)
                }
            } catch let jsonError {
                print("Failed to decode:", jsonError)
            }
        })
            
        task.resume()
    }
    
    // Sort the cards from a full shuffled deck into 4 different suits in ascending order. The result is 4 seperate [Card] that can be mapped to CardModelView
    func sortCards(cards: [Card]) -> CardsInSuit {
        var diamonds = [Card]()
        var clubs = [Card]()
        var hearts = [Card]()
        var spades = [Card]()
        for i in 0..<cards.count {
            if cards[i].suit == "DIAMONDS" {
                diamonds.append(cards[i])
            } else if cards[i].suit == "CLUBS" {
                clubs.append(cards[i])
            } else if cards[i].suit == "HEARTS" {
                hearts.append(cards[i])
            } else {
                spades.append(cards[i])
            }
        }
        
        return CardsInSuit(
                           diamond: diamonds.sorted(by: { ($0.value.localizedStandardCompare($1.value) == .orderedAscending)}),
                           club: clubs.sorted(by: { ($0.value.localizedStandardCompare($1.value) == .orderedAscending)}),
                           heart: hearts.sorted(by: { ($0.value.localizedStandardCompare($1.value) == .orderedAscending)}),
                           spade: spades.sorted(by: { ($0.value.localizedStandardCompare($1.value) == .orderedAscending)})
                            )
    }
    

    // Download card image
    func downloadCard(cardUrl: String, value: String, suit: String, completion: @escaping (CardImage?, Error?) -> ()) {
            let url = URL(string: cardUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                DispatchQueue.main.async(execute: {
                    let imageToCache = UIImage(data: data!)
                    let cardImage = CardImage(image: imageToCache!, url: cardUrl, value: value, suit: suit)
                    completion(cardImage, nil)
                })
                
            }).resume()
        }
    
    
    
    
    

}
