//
//  Spot.swift
//  Minesweeper Deluxe
//
//  Created by Alex on 25.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

class Spot {
    var isMined : Bool {
        return self.state == State.Mined ? true : false
    }
    var state : State
    var revealed : Bool = false
    var flagged : Bool = false
    
    enum State : String {
        case Empty
        case Closed
        case Mined
        case One
        case Two
        case Three
        case Four
        case Five
        case Six
        case Seven
        case Eight
        
    }
    init() {
        self.state = .Closed
    }
    
    init(state: State) {
        self.state = state
    }
    
    func setState(by number:Int){
        switch number {
            case -1: state = .Closed
            case 0: state = .Empty
            case 1: state = .One
            case 2: state = .Two
            case 3: state = .Three
            case 4: state = .Four
            case 5: state = .Five
            case 6: state = .Six
            case 7: state = .Seven
            case 8: state = .Eight
            default: state = .Closed
        }
    }
}
