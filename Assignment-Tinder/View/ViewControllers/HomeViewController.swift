//
//  ViewController.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var cards = [PersonCardView]()
    var favPeoples: [PersonBO]? = []
    var peoples: [PersonBO]? = []
    var dynamicAnimator: UIDynamicAnimator!
    var cardAttachmentBehavior: UIAttachmentBehavior!
    let cardAttributes: [(downscale: CGFloat, alpha: CGFloat)] = [(1, 1), (0.92, 0.8), (0.84, 0.6), (0.76, 0.4)]
    let cardInteritemSpacing: CGFloat = 10
    var cardIsHiding = false
    let userDefaults = UserDefaults.standard
    lazy var viewModel: PersonsViewModel = {
        let viewModel = PersonsViewModel()
        return viewModel
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        self.bindViewModel()
        self.fetchRecords()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func fetchRecords() {
        self.loader.startAnimating()
        self.viewModel.fetchPersons(queryParams: "50")
    }
    
    @IBAction func favMenuChanged(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "FavouriteViewController") as? FavouriteViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func refreshMenuChanged(_ sender: Any) {
        //self.viewModel.fetchPersons(queryParams: "50")
    }
    
    private func bindViewModel() {
        viewModel.$peoples.sink { [weak self] results in
            self?.peoples = results
            self?.loadCards()
        }.store(in: &cancellables)
    }
    
    func loadCards() {
        self.loader.stopAnimating()
        for person in self.peoples ?? [] {
            guard let view = UINib(nibName: "PersonCardView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? PersonCardView else {
                return
            }
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: self.view.frame.height * 0.5)
            view.setData(dataObject: person)
            self.cards.append(view)
        }
        self.layoutCards()
    }

    func layoutCards() {
        if cards.count > 0 {
            let firstCard = cards[0]
            self.view.addSubview(firstCard)
            firstCard.layer.zPosition = CGFloat(cards.count)
            firstCard.center = self.view.center
            firstCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPan)))
            
            // the next 3 cards in the deck
            for i in 1...3 {
                if i > (cards.count - 1) { continue }
                
                let card = cards[i]
                
                card.layer.zPosition = CGFloat(cards.count - i)
                
                let downscale = cardAttributes[i].downscale
                let alpha = cardAttributes[i].alpha
                card.transform = CGAffineTransform(scaleX: downscale, y: 1)
                card.alpha = alpha
                
                card.center.x = self.view.center.x
                print("center \(card.center.x)")
                card.frame.origin.y = cards[0].frame.origin.y + (CGFloat(i) * cardInteritemSpacing)
                print(card.frame.origin.y)
                self.view.addSubview(card)
            }
            self.view.bringSubviewToFront(cards[0])
        }
    }
    
    func showNextCard() {
        let animationDuration: TimeInterval = 0.2
        for i in 1...3 {
            if i > (cards.count - 1) { continue }
            let card = cards[i]
            let newDownscale = cardAttributes[i - 1].downscale
            let newAlpha = cardAttributes[i - 1].alpha
            UIView.animate(withDuration: animationDuration, delay: (TimeInterval(i - 1) * (animationDuration / 2)), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                card.transform = CGAffineTransform(scaleX: newDownscale, y: 1)
                card.alpha = newAlpha
                if i == 1 {
                    card.center = self.view.center
                } else {
                    card.center.x = self.view.center.x
                    card.frame.origin.y = self.cards[1].frame.origin.y + (CGFloat(i) * self.cardInteritemSpacing)
                }
            }, completion: { (_) in
                if i == 1 {
                    card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan)))
                }
            })
            
        }
        
        if 4 > (cards.count - 1) {
            if cards.count != 1 {
                self.view.bringSubviewToFront(cards[1])
            }
            return
        }
        let newCard = cards[4]
        newCard.layer.zPosition = CGFloat(cards.count - 4)
        let downscale = cardAttributes[3].downscale
        let alpha = cardAttributes[3].alpha
        
        // initial state of new card
        newCard.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        newCard.alpha = 0
        newCard.center.x = self.view.center.x
        newCard.frame.origin.y = cards[1].frame.origin.y + (4 * cardInteritemSpacing)
        self.view.addSubview(newCard)
        
        // animate to end state of new card
        UIView.animate(withDuration: animationDuration, delay: (3 * (animationDuration / 2)), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            newCard.transform = CGAffineTransform(scaleX: downscale, y: 1)
            newCard.alpha = alpha
            newCard.center.x = self.view.center.x
            newCard.frame.origin.y = self.cards[1].frame.origin.y + (3 * self.cardInteritemSpacing) + 8
        }, completion: { (_) in
            
        })
        // first card needs to be in the front for proper interactivity
        self.view.bringSubviewToFront(self.cards[1])
    }
    
    func removeOldFrontCard() {
        cards[0].removeFromSuperview()
        self.peoples?.remove(at: 0)
        cards.remove(at: 0)
    }

    @objc func handleCardPan(sender: UIPanGestureRecognizer) {
        // if we're in the process of hiding a card, don't let the user interace with the cards yet
        if cardIsHiding { return }

        // change this to your discretion - it represents how far the user must pan up or down to change the option
        // distance user must pan right or left to trigger an option
        let requiredOffsetFromCenter: CGFloat = 15
        
        let panLocationInView = sender.location(in: view)
        let panLocationInCard = sender.location(in: cards[0])
        switch sender.state {
        case .began:
            dynamicAnimator.removeAllBehaviors()
            let offset = UIOffset(horizontal: panLocationInCard.x - cards[0].bounds.midX, vertical: panLocationInCard.y - cards[0].bounds.midY);
            cardAttachmentBehavior = UIAttachmentBehavior(item: cards[0], offsetFromCenter: offset, attachedToAnchor: panLocationInView)
            dynamicAnimator.addBehavior(cardAttachmentBehavior)
        case .changed:
            cardAttachmentBehavior.anchorPoint = panLocationInView
        case .ended:
            dynamicAnimator.removeAllBehaviors()
                if !(cards[0].center.x > (self.view.center.x + requiredOffsetFromCenter) || cards[0].center.x < (self.view.center.x - requiredOffsetFromCenter)) {
                    let snapBehavior = UISnapBehavior(item: cards[0], snapTo: self.view.center)
                    dynamicAnimator.addBehavior(snapBehavior)
                } else {
                    let velocity = sender.velocity(in: self.view)
                    let pushBehavior = UIPushBehavior(items: [cards[0]], mode: .instantaneous)
                    pushBehavior.pushDirection = CGVector(dx: velocity.x/10, dy: velocity.y/10)
                    pushBehavior.magnitude = 175
                    dynamicAnimator.addBehavior(pushBehavior)
                    var angular = CGFloat.pi / 2
                    let currentAngle: Double = atan2(Double(cards[0].transform.b), Double(cards[0].transform.a))
                    if currentAngle > 0 {
                        angular = angular * 1
                        print("right")
                        self.saveFavObj()
                    } else {
                        print("left")
                        angular = angular * -1
                    }
                    let itemBehavior = UIDynamicItemBehavior(items: [cards[0]])
                    itemBehavior.friction = 0.2
                    itemBehavior.allowsRotation = true
                    itemBehavior.addAngularVelocity(CGFloat(angular), for: cards[0])
                    dynamicAnimator.addBehavior(itemBehavior)
                    
                    showNextCard()
                    hideFrontCard()
                }
        default:
            break
        }
    }

    func hideFrontCard() {
        if #available(iOS 10.0, *) {
            var cardRemoveTimer: Timer? = nil
            cardRemoveTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (_) in
                guard self != nil else { return }
                if !(self!.view.bounds.contains(self!.cards[0].center)) {
                    cardRemoveTimer!.invalidate()
                    self?.cardIsHiding = true
                    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
                        self?.cards[0].alpha = 0.0
                    }, completion: { (_) in
                        self?.removeOldFrontCard()
                        self?.cardIsHiding = false
                    })
                }
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 1.5, options: [.curveEaseIn], animations: {
                self.cards[0].alpha = 0.0
            }, completion: { (_) in
                self.removeOldFrontCard()
            })
        }
    }
    
    func saveFavObj() {
        do {
            favPeoples = try userDefaults.getObject(forKey: "MyFavouriteList", castTo: [PersonBO].self)
        } catch {
            print(error.localizedDescription)
        }
        do {
            guard let obj = self.peoples?[0] else { return }
            favPeoples?.append(obj)
            try userDefaults.setObject(favPeoples, forKey: "MyFavouriteList")
            self.favPeoples?.removeAll()
        } catch {
            print(error.localizedDescription)
        }
    }

}

