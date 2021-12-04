//
//  BishopTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class BishopTests: XCTestCase {
    func testBishopRules() {
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 2, row: 7, imageName: "", isBlack: false, chessRank: .rook))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . x . . . .
           6 . . . . . . . .
           7 . . b . . . . .
    */
        
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 2, fromRow: 7, toColumn: 3, toRow: 5, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . x . . .
           6 . . . p . . . .
           7 . . b . . . . .
    */
        
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 6, imageName: "", isBlack: false, chessRank: .pawn))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 2, fromRow: 7, toColumn: 4, toRow: 5, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . x
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . p . . . .
           7 . . b . . . . .
    */
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 2, fromRow: 7, toColumn: 7, toRow: 2, isWhite: true))
        
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 3, imageName: "", isBlack: false, chessRank: .bishop))
        
        /*
             0 1 2 3 4 5 6 7
           0 x . . . . . . .
           1 . n . . . . . .
           2 . . . . n . . .
           3 . . . b . . . .
           4 . . . . . . . .
           5 . n . . . . . .
           6 x . . . . . n .
           7 . . . . . . . x
    */
        chessEngine.pieces.insert(ChessPiece(column: 1, row: 1, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 4, row: 2, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 6, row: 6, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 1, row: 5, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 0, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 6, toRow: 0, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 7, toRow: 7, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 6, isWhite: false))
    }

}
