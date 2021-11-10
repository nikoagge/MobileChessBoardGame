//
//  ChessEngine.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 10/11/21.
//

import Foundation

struct ChessEngine {
    var pieces: Set<ChessPiece> = Set<ChessPiece>()
    
    mutating func initializeGame() {
        pieces.removeAll()
        pieces.insert(ChessPiece(column: 0, row: 0, imageName: "Rook-black"))
        pieces.insert(ChessPiece(column: 7, row: 0, imageName: "Rook-black"))
        pieces.insert(ChessPiece(column: 0, row: 7, imageName: "Rook-white"))
        pieces.insert(ChessPiece(column: 7, row: 7, imageName: "Rook-white"))
        pieces.insert(ChessPiece(column: 1, row: 0, imageName: "Knight-black"))
        pieces.insert(ChessPiece(column: 6, row: 0, imageName: "Knight-black"))
        pieces.insert(ChessPiece(column: 1, row: 7, imageName: "Knight-white"))
        pieces.insert(ChessPiece(column: 6, row: 7, imageName: "Knight-white"))
        pieces.insert(ChessPiece(column: 2, row: 0, imageName: "Bishop-black"))
        pieces.insert(ChessPiece(column: 5, row: 0, imageName: "Bishop-black"))
        pieces.insert(ChessPiece(column: 2, row: 7, imageName: "Bishop-white"))
        pieces.insert(ChessPiece(column: 5, row: 7, imageName: "Bishop-white"))
        pieces.insert(ChessPiece(column: 3, row: 0, imageName: "Queen-black"))
        pieces.insert(ChessPiece(column: 3, row: 7, imageName: "Queen-white"))
        pieces.insert(ChessPiece(column: 4, row: 0, imageName: "King-black"))
        pieces.insert(ChessPiece(column: 4, row: 7, imageName: "King-white"))
        pieces.insert(ChessPiece(column: 0, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 1, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 2, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 3, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 4, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 5, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 6, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 7, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(column: 0, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 1, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 2, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 3, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 4, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 5, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 6, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(column: 7, row: 6, imageName: "Pawn-white"))
    }
}
