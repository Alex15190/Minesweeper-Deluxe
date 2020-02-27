//
//  GameViewController.swift
//  Minesweeper Deluxe
//
//  Created by Alex on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

struct GameConstants {
    static var cellSize = 60
}

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func restartGame(_ sender: Any) {
        game.start()
        collectionView.reloadData()
    }
    var horizontalNumOfCells = 5
    var verticalNumOfCells = 6
    var numOfMines = 4
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.game.start()
        collectionView.reloadData()
    }
    
    func getCoordinatesFrom(indexPath : IndexPath) -> (width : Int,height : Int){
        
        let h = (Int)(indexPath.item / horizontalNumOfCells)
        let w = ((indexPath.item + 1) % horizontalNumOfCells) == 0 ? (horizontalNumOfCells - 1) : (((indexPath.item + 1) % horizontalNumOfCells) - 1)
        return (w,h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = GameConstants.cellSize
        return CGSize(width: a, height: a)
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
            let field = game.field[w][h]
            if (field.revealed){
                scell.imageView.image = UIImage(named: field.state.rawValue)
            }
            else{
                scell.imageView.image = UIImage(named: "Closed")
            }
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
