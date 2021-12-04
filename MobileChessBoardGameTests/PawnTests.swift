//
//  PawnTests.swift
//  MobileChessBoardGameTests
//
//  Created by Nikos Aggelidis on 4/12/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import XCTest
@testable import MobileChessBoardGame

class PawnTests: XCTestCase {
    func testWhitePawnRules() {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . o . .
           5 . . . . x o x .
           6 . . . . x p x .
           7 . . . . . . . .
    */
        var chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 6, imageName: "", isBlack: false, chessRank: .pawn))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 6, toRow: 5, isWhite: true))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5, isWhite: true))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . x . .
           5 . . . . . N . .
           6 . . . . . p . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 6, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 5, imageName: "", isBlack: true, chessRank: .knight))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4, isWhite: true))

        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . . . .
           4 . . . . . N . .
           5 . . . . . . . .
           6 . . . . . p . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 6, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . x o x .
           4 . . . . x p x .
           5 . . . . x x x .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .pawn))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 4, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 5, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 5, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 4, isWhite: true))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . N . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3, isWhite: true))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . x . .
           3 . . . . . . . .
           4 . . . . . p . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .pawn))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 2, isWhite: true))

        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . N . N .
           4 . . . . . p . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 4, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 6, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3, isWhite: true))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3, isWhite: true))
    }
    
    func testBlackPawnRules() {
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . P . .
           2 . . . . . o x .
           3 . . . . . o . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        var chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 1, imageName: "", isBlack: true, chessRank: .pawn))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 6, toRow: 2, isWhite: false))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2, isWhite: false))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3, isWhite: false))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . P . .
           2 . . . . . n . .
           3 . . . . . x . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 1, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 2, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3, isWhite: false))

        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . P . .
           2 . . . . . . . .
           3 . . . . . n . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 1, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3, isWhite: false))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . x x x .
           4 . . . . x P x .
           5 . . . . x o x .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: true, chessRank: .pawn))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 5, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 4, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 5, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 4, isWhite: false))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3, isWhite: false))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . . . .
           3 . . . . . P . .
           4 . . . . . n . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 3, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 4, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertFalse(chessEngine.canPieceMove(fromColumn: 5, fromRow: 3, toColumn: 5, toRow: 4, isWhite: false))

        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . . . . . . .
           2 . . . . . P . .
           3 . . . . n . n .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.pieces.insert(ChessPiece(column: 5, row: 2, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 4, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        chessEngine.pieces.insert(ChessPiece(column: 6, row: 3, imageName: "", isBlack: false, chessRank: .knight))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 2, toColumn: 4, toRow: 3, isWhite: false))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 5, fromRow: 2, toColumn: 6, toRow: 3, isWhite: false))
        
        /*
             0 1 2 3 4 5 6 7
           0 . . . . . . . .
           1 . . P . . . . .
           2 . . . p . . . .
           3 . . . . . . . .
           4 . . . . . . . .
           5 . . . . . . . .
           6 . . . . . . . .
           7 . . . . . . . .
    */
        chessEngine = ChessEngine()
        chessEngine.blackTurn = true
        chessEngine.pieces.insert(ChessPiece(column: 2, row: 1, imageName: "", isBlack: true, chessRank: .pawn))
        chessEngine.pieces.insert(ChessPiece(column: 3, row: 2, imageName: "", isBlack: false, chessRank: .pawn))
        XCTAssertTrue(chessEngine.canPieceMove(fromColumn: 2, fromRow: 1, toColumn: 3, toRow: 2, isWhite: false))
    }
    
    func testCanPawnAttach() {
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
        XCTAssertTrue(chessEngine.canPawnAttack(fromColumn: 0, fromRow: 6, toColumn: 1, toRow: 5))
        XCTAssertFalse(chessEngine.canPawnAttack(fromColumn: 0, fromRow: 6, toColumn: 0, toRow: 5))
        XCTAssertTrue(chessEngine.canPawnAttack(fromColumn: 7, fromRow: 1, toColumn: 6, toRow: 2))
        XCTAssertFalse(chessEngine.canPawnAttack(fromColumn: 7, fromRow: 1, toColumn: 7, toRow: 2))
    }
}
