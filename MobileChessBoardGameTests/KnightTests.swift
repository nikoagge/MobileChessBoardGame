//
//  KnightTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class KnightTests: XCTestCase {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . x . . . . . .
           6 . . . . . . . .
           7 . n . . . . . .
    */
    
    func testKnightRules() {
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 1, row: 7, imageName: "", isBlack: false, chessRank: .knight))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . x . . . . . .
           6 . . . . . . . .
           7 . n . . . . . .
    */
        
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 1, fromRow: 7, toColumn: 1, toRow: 5, isWhite: true))
    }
}
