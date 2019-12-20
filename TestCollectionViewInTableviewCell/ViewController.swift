//
//  ViewController.swift
//  TestCollectionViewInTableviewCell
//
//  Created by Franklin Samboní on 18/12/19.
//  Copyright © 2019 Franklin Samboní. All rights reserved.
//

import UIKit

struct Card {
    var title: String?
    var text: String
    
}

struct Message {
    var cards: [Card]?
    var selectedPosition: Int = 0
}

protocol DataCollectionViewCell: class{
    func saveCollectionViewCurrentCell(cellIndexPath: IndexPath, position: Int)
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAdd(_ sender: Any) {
        var cards: [Card] = []
        let messageNumer = messages.count
        let totalcards = Int.random(in: 3..<10)
        for i in 1..<totalcards {
            cards.append(Card(title: "\(messageNumer) Title \(i) de \(totalcards-1)", text: "\(messageNumer) Text \(i) de \(totalcards-1)"))
        }
        messages.append(Message(cards: cards))
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as! CollectionViewTableViewCell
        print("tableViewIndexPath: \(indexPath)")
        cell.setup(delegate: self, indexPath: indexPath, message: messages[indexPath.row])
        return cell
    }
    
}


extension ViewController: DataCollectionViewCell {
    func saveCollectionViewCurrentCell(cellIndexPath: IndexPath, position: Int){
        print("dataForCollectionViewCellIndexPath: \(cellIndexPath)")
        if messages.count > cellIndexPath.row{
            messages[cellIndexPath.row].selectedPosition = position
        }
    }
}

