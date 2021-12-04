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
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 0, fromRow: 7, toColumn: -1, toRow: 7, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 0, fromRow: 7, toColumn: 8, toRow: 7, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 8, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: -1, isWhite: false))
    }
    
    func testAvoidCapturingOwnPieces() {
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 0, fromRow: 7, toColumn: 0, toRow: 6, isWhite: true))
    }
    
    func testWhiteEnPassant() {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . o . . .
           3 . . . . P p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 3, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 4, row: 3, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.lastChessPieceMove = ChessPieceMove(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 3)
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 3, toColumn: 4, toRow: 2, isWhite: false))
        
        XCTAssertNotNil(chessEngine.pieceAt(column: 4, row: 3))
        chessEngine.movePiece(fromColumn: 5, fromRow: 3, toColumn: 4, toRow: 2)
        XCTAssertNil(chessEngine.pieceAt(column: 4, row: 3))
        XCTAssertNotNil(chessEngine.pieceAt(column: 4, row: 2))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
         
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P P P P P
           2 N . . . . . . .
           3 . . . . . . . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
         
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P P P P P
           2 N . . . . . . .
           3 . . . . . p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
    */
        chessEngine = ChessEngine()
        chessEngine.initializeGame()
        debugPrint(chessEngine)
        
        chessEngine.movePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4)
        chessEngine.movePiece(fromColumn: 1, fromRow: 0, toColumn: 0, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3)
        XCTAssertNotNil(chessEngine.pieceAt(column: 0, row: 2))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
         
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P P P P P
           2 N . . . . . . .
           3 . . . . . . . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
         
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P P P P P
           2 N . . . . . . .
           3 . . . . . p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
         
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P . P P P
           2 N . . . . . . .
           3 . . . . P p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
    */
        chessEngine = ChessEngine()
        chessEngine.initializeGame()
        debugPrint(chessEngine)
        
        chessEngine.movePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4)
        chessEngine.movePiece(fromColumn: 1, fromRow: 0, toColumn: 0, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3)
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 3)
        XCTAssertNotNil(chessEngine.pieceAt(column: 0, row: 2))
        XCTAssertNotNil(chessEngine.pieceAt(column: 5, row: 3))
        
        /*
        0 1 2 3 4 5 6 7
      0 R N B Q K B N R
      1 . . . P P P P P
      2 P P P . . . . .
      3 . . . . . . . .
      4 . . . . . . . .
      5 . . . . . p . n
      6 p p p p p . p p
      7 r n b q . r k .
    */
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 7))
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 6, toRow: 7)
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 7))
    }
    
    func testBlackEnPassant() {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . P p .
           5 . . . . . . o .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 6, row: 4, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.lastChessPieceMove = ChessPieceMove(fromColumn: 6, fromRow: 6, toColumn: 6, toRow: 4)
        chessEngine.blackTurn = true
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5, isWhite: true))
        
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 4))
        chessEngine.movePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5)
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 4))
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 5))
    }
    
    func testThreat() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P . P P P P
           2 . . . P . . . .
           3 . . . . . p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
    */
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4)
        chessEngine.movePiece(fromColumn: 3, fromRow: 1, toColumn: 3, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3)
        XCTAssertTrue(chessEngine.underThreatAt(column: 5, row: 3, whiteEnemy: false))
        
        /*
             0 1 2 3 4 5 6 7
           0 R . B Q K B N R
           1 P P P P P P P P
           2 N . . . . . . .
           3 . . . . . p . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p . p p
           7 r n b q k b n r
    */
        chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4)
        chessEngine.movePiece(fromColumn: 1, fromRow: 0, toColumn: 0, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3)
        XCTAssertFalse(chessEngine.underThreatAt(column: 5, row: 3, whiteEnemy: false))
    }
}
