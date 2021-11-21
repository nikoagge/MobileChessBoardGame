//
//  ChessEngineTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 16/11/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class ChessEngineTests: XCTestCase {
    func testPrintingEmptyGameBoard() {
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        debugPrint(chessEngine)
    }
    
    func testChessPieceNotAllowedToGoOutOfBoardView() {
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        debugPrint(chessEngine)
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: -1, toRow: 7))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 8, toRow: 7))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 8))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: -1))
    }
    
    func testAvoidCapturingOwnPieces() {
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 6))
    }
    
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
        
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 1, fromRow: 7, toColumn: 1, toRow: 5))
    }
    
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 1, toRow: 6))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 5))
    }
}
