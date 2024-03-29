//
//  CollectionViewTableViewCell.swift
//  TestCollectionViewInTableviewCell
//
//  Created by Franklin Samboní on 18/12/19.
//  Copyright © 2019 Franklin Samboní. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate: DataCollectionViewCell?
    var collectionViewIndexPath: IndexPath?
    var message: Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didMoveToSuperview() {
        self.collectionView.reloadData()
    }
    
    
    func setup(delegate: DataCollectionViewCell, indexPath: IndexPath, message:Message){
        self.delegate = delegate
        self.collectionViewIndexPath = indexPath
        self.message = message
        pageControl.numberOfPages = message.cards?.count ?? 0
        pageControl.currentPage = message.selectedPosition
        self.collectionView.reloadData()
        if pageControl.numberOfPages > 0 && pageControl.numberOfPages > message.selectedPosition {
            self.collectionView.scrollToItem(at: IndexPath(row: message.selectedPosition, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        }
        //self.collectionView.reloadData()
    }
    
    override func prepareForReuse() {
        //self.collectionViewIndexPath = nil
    }
}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let message = message {
            return message.cards?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let cards = message?.cards {
            if  cards.count > indexPath.row{
                cell.setup(card: cards[indexPath.row])
            }
            else{
                print("INDEXPATH: \(indexPath) - CARDS: \(cards.count)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 158)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.frame.size.width
        pageControl.currentPage = Int(index)
        if let collectionViewIndexPath = collectionViewIndexPath {
            delegate?.saveCollectionViewCurrentCell(cellIndexPath: collectionViewIndexPath, position:  Int(index))
        }
        
    }
}
