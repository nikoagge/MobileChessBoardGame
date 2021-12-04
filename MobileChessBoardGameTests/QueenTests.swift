//
//  QueenTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class QueenTests: XCTestCase {
    func testQueenRules() {
        var chessEngine = ChessEngine()
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . x . .
           6 . . . . . . . .
           7 . . . x . . . .
    */
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 5, toRow: 5, isWhite: true))
        
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 7, imageName: "", isBlack: false, chessRank: .queen))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . o . .
           6 . . . . . . . .
           7 . . . q . . . .
    */
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 5, toRow: 5, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . x . . .
           6 . . . . . . . .
           7 . . . q . . . .
    */
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 4, toRow: 5, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 x . . . . . x .
           1 . n . . . . . .
           2 . . . . n . . .
           3 . . . q . . . .
           4 . . . . . . . .
           5 . n . . . . . .
           6 x . . . . . n .
           7 . . . . . . . x
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 3, imageName: "", isBlack: false, chessRank: .queen))
        chessEngine.pieces.insert(ChessPiece(column: 1, row: 1, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 4, row: 2, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 6, row: 26, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 1, row: 5, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 0, isWhite: false))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 6, toRow: 0, isWhite: false))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 7, toRow: 7, isWhite: false))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 6, isWhite: false))
    }
    
    func testWhiteQueenSideCastlingRules() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . . . P P P
           2 P P P P P . . .
           3 . . . . . . . .
           4 . . p . . . . .
           5 n q . p . . . .
           6 p p . b p p p p
           7 r . . . k b n r
    */
        
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 2, fromRow: 6, toColumn: 2, toRow: 4)
        chessEngine.movePiece(fromColumn: 0, fromRow: 1, toColumn: 0, toRow: 2)
        chessEngine.movePiece(fromColumn: 3, fromRow: 7, toColumn: 1, toRow: 5)
        chessEngine.movePiece(fromColumn: 1, fromRow: 1, toColumn: 1, toRow: 2)
        chessEngine.movePiece(fromColumn: 1, fromRow: 7, toColumn: 0, toRow: 5)
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        chessEngine.movePiece(fromColumn: 3, fromRow: 6, toColumn: 3, toRow: 5)
        chessEngine.movePiece(fromColumn: 3, fromRow: 1, toColumn: 3, toRow: 2)
        chessEngine.movePiece(fromColumn: 2, fromRow: 7, toColumn: 3, toRow: 6)
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        XCTAssertTrue(chessEngine.canCastle(toColumn: 2, toRow: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . . . P P P
           2 P P P P P . . .
           3 . . . . . . . .
           4 . . p . . . . .
           5 n q . p . . . .
           6 p p . b p p p p
           7 r . . . k b n r
    */
        XCTAssertNil(chessEngine.pieceAt(column: 1, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column:2, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 3, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 0, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 4, row: 7))
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 2, toRow: 7)
        XCTAssertNil(chessEngine.pieceAt(column: 1, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 2, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 3, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 0, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 4, row: 7))
    }

}
