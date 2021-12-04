//
//  KingTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class KingTests: XCTestCase {
    func testKingRules() {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . x . . .
           2 . . . . . . . .
           3 . . . k o x . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 3, imageName: "", isBlack: false, chessRank: .king))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 3, toRow: 3, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 5, toRow: 3, isWhite: false))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 4, toRow: 3, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 3, fromRow: 3, toColumn: 4, toRow: 1, isWhite: false))
    }
    
    func testWhiteKingSideCanCastleRules() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 4, fromRow: 6, toColumn: 4, toRow: 5)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . P P P P P P P
           2 P . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 0, fromRow: 1, toColumn: 0, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p b p p p
           7 r n b q k . n r
    */
        chessEngine.movePiece(fromColumn: 5, fromRow: 7, toColumn: 4, toRow: 6)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . P P P P P P
           2 P P . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 6, fromRow: 7, toColumn: 7, toRow: 5)

        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . P P P P P P
           2 P P . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 1, fromRow: 1, toColumn: 1, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . P P P P P
           2 P P P . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        XCTAssertTrue(chessEngine.canCastle(toColumn: 6, toRow: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . . . P P P
           2 P P P P P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 5, toRow: 7)
        chessEngine.movePiece(fromColumn: 3, fromRow: 1, toColumn: 3, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 7, toColumn: 4, toRow: 7)
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        XCTAssertFalse(chessEngine.canCastle(toColumn: 6, toRow: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . P P P P P
           2 P P P . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q . r k .
    */
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 7))
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 6, toRow: 7)
//        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
//        XCTAssertNil(chessEngine.pieceAt(column: 7, row: 7))
//        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
    }
    
    func testWhiteKingSideCastlingRules() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 4, fromRow: 6, toColumn: 4, toRow: 5)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . P P P P P P P
           2 P . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 0, fromRow: 1, toColumn: 0, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p b p p p
           7 r n b q k . n r
    */
        chessEngine.movePiece(fromColumn: 5, fromRow: 7, toColumn: 4, toRow: 6)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . P P P P P P
           2 P P . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 6, fromRow: 7, toColumn: 7, toRow: 5)

        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . P P P P P P
           2 P P . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 1, fromRow: 1, toColumn: 1, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . P P P P P
           2 P P P . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        XCTAssertTrue(chessEngine.canCastle(toColumn: 6, toRow: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . . . P P P
           2 P P P P P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q k . . r
    */
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 5, toRow: 7)
        chessEngine.movePiece(fromColumn: 3, fromRow: 1, toColumn: 3, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 7, toColumn: 4, toRow: 7)
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        XCTAssertFalse(chessEngine.canCastle(toColumn: 6, toRow: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . P P P P P
           2 P P P . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . n
           6 p p p p b p p p
           7 r n b q . r k .
    */
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 7))
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 6, toRow: 7)
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . . . . . . P P
           2 P P P P P P . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . p . n p b
           6 p p p k p p . p
           7 r n b . q . . r
    */
        chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 3, fromRow: 6, toColumn: 3, toRow: 5)
        chessEngine.movePiece(fromColumn: 0, fromRow: 1, toColumn: 0, toRow: 2)
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 3, toRow: 6)
        chessEngine.movePiece(fromColumn: 1, fromRow: 1, toColumn: 1, toRow: 2)
        chessEngine.movePiece(fromColumn: 6, fromRow: 7, toColumn: 5, toRow: 5)
        chessEngine.movePiece(fromColumn: 2, fromRow: 1, toColumn: 2, toRow: 2)
        chessEngine.movePiece(fromColumn: 6, fromRow: 6, toColumn: 6, toRow: 5)
        chessEngine.movePiece(fromColumn: 3, fromRow: 1, toColumn: 3, toRow: 2)
        chessEngine.movePiece(fromColumn: 5, fromRow: 7, toColumn: 7, toRow: 5)
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        chessEngine.movePiece(fromColumn: 3, fromRow: 7, toColumn: 4, toRow: 7)
        chessEngine.movePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2)
        XCTAssertFalse(chessEngine.canCastle(toColumn: 6, toRow: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 7))
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 6, toRow: 7)
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 7))
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 7))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 7))
    }

    func testBlackKingSideCastlingRules() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P . P P P
           2 . . . . P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p p p p
           7 r n b q k b n r
    */
        
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 . P P P P P P P
           2 P . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 4, fromRow: 6, toColumn: 4, toRow: 5)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P . P P P
           2 . . . . P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p p p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 4, fromRow: 1, toColumn: 4, toRow: 2)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P . P P P
           2 . . . . P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p . .
           6 p p p p . . p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5)

        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K . N R
           1 P P P P B P P P
           2 . . . . P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p . .
           6 p p p p . . p p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 5, fromRow: 0, toColumn: 4, toRow: 1)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K . N R
           1 P P P P B P P P
           2 . . . . P . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p p .
           6 p p p p . . . p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 6, fromRow: 6, toColumn: 6, toRow: 5)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K . . R
           1 P P P P B P P P
           2 . . . . P . . N
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p p .
           6 p p p p . . . p
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 6, fromRow: 0, toColumn: 7, toRow: 2)
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K . . R
           1 P P P P B P P P
           2 . . . . P . . N
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p p p
           6 p p p p . . . .
           7 r n b q k b n r
    */
        
        chessEngine.movePiece(fromColumn: 7, fromRow: 6, toColumn: 7, toRow: 5)
        XCTAssertTrue(chessEngine.canCastle(toColumn: 6, toRow: 0))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K . . R
           1 P P P P B P P P
           2 . . . . P . . N
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . p p p p p p
           6 p p . . . . . .
           7 r n b q k b n r
    */
        chessEngine.movePiece(fromColumn: 4, fromRow: 0, toColumn: 5, toRow: 0)
        chessEngine.movePiece(fromColumn: 3, fromRow: 6, toColumn: 3, toRow: 5)
        chessEngine.movePiece(fromColumn: 5, fromRow: 0, toColumn: 4, toRow: 0)
        chessEngine.movePiece(fromColumn: 2, fromRow: 6, toColumn: 2, toRow: 5)
        XCTAssertFalse(chessEngine.canCastle(toColumn: 6, toRow: 0))
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q . R K .
           1 P P P P B P P P
           2 . . . . P . . N
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . p p p p
           6 p p p p . . . .
           7 r n b q k b n r
    */
        XCTAssertNotNil(chessEngine.pieceAt(column: 7, row: 0))
        XCTAssertNil(chessEngine.pieceAt(column: 6, row: 0))
        XCTAssertNil(chessEngine.pieceAt(column: 5, row: 0))
        chessEngine.movePiece(fromColumn: 4, fromRow: 0, toColumn: 6, toRow: 0)
        XCTAssertNotNil(chessEngine.pieceAt(column: 6, row: 0))
        XCTAssertNil(chessEngine.pieceAt(column: 7, row: 0))
        XCTAssertNotNil(chessEngine.pieceAt(column: 5, row: 0))
    }
    
    func testKingThreatenedByPawn() {
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 p p p p p p p p
           7 r n b q k b n r
    */
        
        var chessEngine = ChessEngine()
        chessEngine.initializeGame()
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P P P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . p . . .
           5 . . . . . . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        
        chessEngine.movePiece(fromColumn: 4, fromRow: 6, toColumn: 4, toRow: 4)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P . P P
           2 . . . . . . . .
           3 . . . . . P . .
           4 . . . . p . . .
           5 . . . . . . . .
           6 p p p p . p p p
           7 r n b q k b n r
    */
        
        chessEngine.movePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P . P P
           2 . . . . . . . .
           3 . . . . . P . .
           4 . . . . p . . .
           5 . . . . . . . .
           6 p p p p k p p p
           7 r n b q . b n r
    */
        
        chessEngine.movePiece(fromColumn: 4, fromRow: 7, toColumn: 4, toRow: 6)
        
        /*
             0 1 2 3 4 5 6 7
           0 R N B Q K B N R
           1 P P P P P . P P
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . p P . .
           5 . . . . . . . .
           6 p p p p k p p p
           7 r n b q . b n r
    */
        
        chessEngine.movePiece(fromColumn: 5, fromRow: 3, toColumn: 5, toRow: 4)
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 4, fromRow: 6, toColumn: 4, toRow: 5, isWhite: true))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 4, fromRow: 6, toColumn: 5, toRow: 5, isWhite: true))
    }
}
