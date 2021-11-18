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
}
