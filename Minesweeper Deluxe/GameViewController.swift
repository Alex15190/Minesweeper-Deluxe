//
//  GameViewController.swift
//  Minesweeper Deluxe
//
//  Created by Alex on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

struct GameConstants {
    static var cellWidght = 60
}

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var horizontalNumOfCells = 10
    var verticalNumOfCells = 10
    var numOfMines = 5
    var limitedTime = false
    var time = 120.0
    
    var game : Game
    
    required init?(coder aDecoder: NSCoder) {
        game = Game(height: verticalNumOfCells, width: horizontalNumOfCells, numOfMines: numOfMines)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game = Game(height: verticalNumOfCells, width: horizontalNumOfCells, numOfMines: numOfMines)
        self.game.start()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellSize = GameConstants.cellWidght
        scrollView.contentSize = CGSize(width: horizontalNumOfCells*cellSize, height: verticalNumOfCells*cellSize)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func getCoordinatesFrom(indexPath : IndexPath) -> (width : Int,height : Int){
        
        let h = (Int)((indexPath.item + 1) / horizontalNumOfCells)
        let w = ((indexPath.item + 1) % horizontalNumOfCells) == 0 ? 4 : (((indexPath.item + 1) % horizontalNumOfCells) - 1)
        return (w,h)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontalNumOfCells * verticalNumOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
        if let scell = cell as? SpotCollectionViewCell{
            let coordinates = getCoordinatesFrom(indexPath: indexPath)
            let h = coordinates.height
            let w = coordinates.width
            scell.imageView.image = UIImage(named: game.field[h][w].state.rawValue)
            return scell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coortinates = getCoordinatesFrom(indexPath: indexPath)
        let x = coortinates.width
        let y = coortinates.height
        game.openSpotIn(x: x, y: y)
        collectionView.reloadData()
        if (game.gameOver){
            collectionView.isUserInteractionEnabled = false
        }
    }
    
}
