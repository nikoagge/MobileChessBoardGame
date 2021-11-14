//
//  ChessEngine.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 10/11/21.
//

import Foundation

struct ChessEngine {
    var pieces: Set<ChessPiece> = Set<ChessPiece>()
    var blackTurn = false
    
    mutating func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        if !canMovePiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow) {
            return
        }
        
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return }
        
        if let target = pieceAt(column: toColumn, row: toRow) {
            if target.isBlack == candidate.isBlack {
                return
            }
            pieces.remove(target)
        }
        
        pieces.remove(candidate)
        pieces.insert(ChessPiece(column: toColumn, row: toRow, imageName: candidate.imageName, isBlack: candidate.isBlack))
        blackTurn = !blackTurn
    }
    
    func canMovePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        if fromColumn == toColumn && fromRow == toRow {
            return false
        }
        
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return false }
        
        if candidate.isBlack != blackTurn {
            return false
        }
        return true
    }
    
    func pieceAt(column: Int, row: Int) -> ChessPiece? {
        for piece in pieces {
            if column == piece.column && row == piece.row {
                return piece
            }
        }
        
        return nil
    }
    
    mutating func initializeGame() {
        blackTurn = false
        pieces.removeAll()
        for row in 0..<2 {
            pieces.insert(ChessPiece(column: row * 7, row: 0, imageName: "Rook-black", isBlack: true))
            pieces.insert(ChessPiece(column: row * 7, row: 7, imageName: "Rook-white", isBlack: false))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 0, imageName: "Knight-black", isBlack: true))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 7, imageName: "Knight-white", isBlack: false))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 0, imageName: "Bishop-black", isBlack: true))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 7, imageName: "Bishop-white", isBlack: false))
        }
        
        pieces.insert(ChessPiece(column: 3, row: 0, imageName: "Queen-black", isBlack: true))
        pieces.insert(ChessPiece(column: 3, row: 7, imageName: "Queen-white", isBlack: false))
        pieces.insert(ChessPiece(column: 4, row: 0, imageName: "King-black", isBlack: true))
        pieces.insert(ChessPiece(column: 4, row: 7, imageName: "King-white", isBlack: false))
        
        for column in 0..<8 {
            pieces.insert(ChessPiece(column: column, row: 1, imageName: "Pawn-black", isBlack: true))
            pieces.insert(ChessPiece(column: column, row: 6, imageName: "Pawn-white", isBlack: false))
        }
    }
}
