//
//  ChessEngine.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 10/11/21.
//

import Foundation

struct ChessEngine {
    var pieces: Set<ChessPiece> = Set<ChessPiece>()
    
    mutating func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        if fromColumn == toColumn && fromRow == toRow {
            return
        }
        
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return }
        pieces.remove(candidate)
        pieces.insert(ChessPiece(column: toColumn, row: toRow, imageName: candidate.imageName))
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
        pieces.removeAll()
        for row in 0..<2 {
            pieces.insert(ChessPiece(column: row * 7, row: 0, imageName: "Rook-black"))
            pieces.insert(ChessPiece(column: row * 7, row: 7, imageName: "Rook-white"))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 0, imageName: "Knight-black"))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 7, imageName: "Knight-white"))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 0, imageName: "Bishop-black"))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 7, imageName: "Bishop-white"))
        }
        
        pieces.insert(ChessPiece(column: 3, row: 0, imageName: "Queen-black"))
        pieces.insert(ChessPiece(column: 3, row: 7, imageName: "Queen-white"))
        pieces.insert(ChessPiece(column: 4, row: 0, imageName: "King-black"))
        pieces.insert(ChessPiece(column: 4, row: 7, imageName: "King-white"))
        
        for column in 0..<8 {
            pieces.insert(ChessPiece(column: column, row: 1, imageName: "Pawn-black"))
            pieces.insert(ChessPiece(column: column, row: 6, imageName: "Pawn-white"))
        }
    }
}
