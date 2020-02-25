//
//  Game.swift
//  Minesweeper Deluxe
//
//  Created by Alex on 25.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

class Game{
    var gridW : Int
    var gridH : Int
    var numOfMines : Int
    
    var field : [[Spot]] = [[]]
    
    init(height : Int , width : Int, numOfMines: Int){
        gridH = height
        gridW = width
        self.numOfMines = numOfMines
    }
    
    func outOfBounds(x: Int, y: Int) -> Bool{
        return x<0 || y<0 || x>=gridW || y>=gridH
    }
    
    func calcNearMines(x: Int, y: Int) -> Int {
        if(outOfBounds(x: x, y: y)){ return 0}
        var counter = 0
        for offsetX in -1...1{
            for offsetY in -1...1{
                if(outOfBounds(x: offsetX + x, y: offsetY + y)) {continue}
                else if (field[x+offsetX][y+offsetY].mined) {
                    counter += 1
                }
            }
        }
        field[x][y].setState(by: counter)
        return counter
    }
    
    func reveal(x: Int, y: Int){
        if(outOfBounds(x: x, y: y)){return}
        if(field[x][y].revealed){return}
        field[x][y].revealed = true
        if(calcNearMines(x: x, y: y) != 0){return}
        for i in x-1...x+1 {
            for j in y-1...y+1{
                //один раз себя вызвали, но ничего страшного
                reveal(x: i, y: j)
            }
        }
    }
    
    func placeMines(){
        var counter = 0
        while (counter < numOfMines) {
            let x = Int.random(in: 0..<gridW)
            let y = Int.random(in: 0..<gridH)
            if (field[x][y].mined){continue}
            field[x][y].state = .Mined
            counter += 1
        }
    }
    
    func clearMines(){
        for x in 0..<gridW {
            for y in 0..<gridH {
                field[x][y].state = .Empty
            }
        }
    }
}
