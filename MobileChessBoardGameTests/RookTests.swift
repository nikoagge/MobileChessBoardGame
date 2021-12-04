//
//  RookTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class RookTests: XCTestCase {
    func testRookRules() {
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 0, row: 7, imageName: "", isBlack: false, chessRank: .rook))
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . x . . . . . .
           7 r . . . . . . .
    */
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 1, toRow: 6, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 o . . . . . . .
           6 . . . . . . . .
           7 r . . . . . . .
    */
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 5, isWhite: true))
    }
}
