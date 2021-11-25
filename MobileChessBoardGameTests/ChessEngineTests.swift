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
        
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 2, fromRow: 7, toColumn: 3, toRow: 5))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 2, fromRow: 7, toColumn: 4, toRow: 5))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 2, fromRow: 7, toColumn: 7, toRow: 2))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 0))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 6, toRow: 0))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 7, toRow: 7))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 6))
    }
    
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 5, toRow: 5))
        
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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 5, toRow: 5))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 7, toColumn: 4, toRow: 5))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 0))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 6, toRow: 0))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 7, toRow: 7))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 0, toRow: 6))
    }
    
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 3, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 5, toRow: 3))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 4, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 3, fromRow: 3, toColumn: 4, toRow: 1))
    }
    
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 6, toRow: 5))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4))

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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 6, toColumn: 5, toRow: 4))
        
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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 4))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 4))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3))

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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3))
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 6, toRow: 2))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3))

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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 2))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 1, toColumn: 5, toRow: 3))
        
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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 4))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 4, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 5, toRow: 3))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 5))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 4))
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 4, toColumn: 6, toRow: 3))
        
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
        XCTAssertFalse(chessEngine.canMovePiece(fromColumn: 5, fromRow: 3, toColumn: 5, toRow: 4))

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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 2, toColumn: 4, toRow: 3))
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 5, fromRow: 2, toColumn: 6, toRow: 3))
        
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
        XCTAssertTrue(chessEngine.canMovePiece(fromColumn: 2, fromRow: 1, toColumn: 3, toRow: 2))
    }
}
