//
//  ChessEngine.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 10/11/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import Foundation

struct ChessEngine {
    var pieces: Set<ChessPiece> = Set<ChessPiece>()
    var blackTurn = false
    
    mutating func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return }
        
        if let target = pieceAt(column: toColumn, row: toRow) {
            if target.isBlack == candidate.isBlack {
                return
            }
            pieces.remove(target)
        }
        
        pieces.remove(candidate)
        pieces.insert(ChessPiece(column: toColumn, row: toRow, imageName: candidate.imageName, isBlack: candidate.isBlack, chessRank: candidate.chessRank))
        blackTurn = !blackTurn
    }
    
    func canMovePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        if toColumn < 0 || toColumn > 7 || toRow < 0 || toRow > 7 {
            return false
        }
        
        if fromColumn == toColumn && fromRow == toRow {
            return false
        }
        
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return false }
        
        if let target = pieceAt(column: toColumn, row: toRow), target.isBlack == candidate.isBlack {
            return false
        }
        
        if candidate.isBlack != blackTurn {
            return false
        }
        
        switch candidate.chessRank {
        case .knight:
            return canMoveKnight(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .rook:
            return canMoveRook(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .bishop:
            return canMoveBishop(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .queen:
            return canMoveQueen(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        default:
            return true
        }        
    }
    
    func canMoveKnight(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        return abs(fromColumn - toColumn) == 1 && abs(fromRow - toRow) == 2 || abs(fromRow - toRow) == 1 && abs(fromColumn - toColumn) == 2
    }
    
    func canMoveRook(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        guard emptyBetween(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow) else { return false }
        
        return fromColumn == toColumn || fromRow == toRow
    }
    
    func canMoveBishop(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        guard emptyBetween(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow) else { return false }
        
        return abs(fromColumn - toColumn) == abs(fromRow - toRow)
    }
    
    func emptyBetween(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        if fromRow == toRow { //horizontal move
            let minColumn = min(fromColumn, toColumn)
            let maxColumn = max(fromColumn, toColumn)
            if maxColumn - minColumn < 2 {
                return true
            }
            for index in minColumn+1...maxColumn-1 {
                if pieceAt(column: index, row: fromRow) != nil {
                    return false
                }
            }
            
            return true
        } else if fromColumn == toColumn { //vertical move
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            if maxRow - minRow < 2 {
                return true
            }
            for index in minRow+1...maxRow-1 {
                if pieceAt(column: fromColumn, row: index) != nil {
                    return false
                }
            }
            
            return true
        } else if abs(fromColumn - toColumn) == abs(fromRow - toRow) { //diagonal move
            let minColumn = min(fromColumn, toColumn)
            let maxColumn = max(fromColumn, toColumn)
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            if fromRow - toRow == fromColumn - toColumn { //top left to bottom right
                if maxColumn - minColumn < 2 {
                    return true
                }
                for index in 1..<abs(fromColumn - toColumn) {
                    if pieceAt(column: minColumn + index, row: minRow + index) != nil {
                        return false
                    }
                }
                
                return true
            } else { //bottom left to top right
                if maxColumn - minColumn < 2 {
                    return true
                }
                for index in 1..<abs(fromColumn - toColumn) {
                    if pieceAt(column: minColumn + index, row: maxRow - index) != nil {
                        return false
                    }
                }
                
                return true
            }
        }
        
        return false
    }
    
    func canMoveQueen(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        return canMoveRook(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow) || canMoveBishop(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
    }
    
    func emptyBetween(from: Int, to: Int, constant: Int) -> Bool {
        let minColumn = min(from, to)
        let maxColumn = max(from, to)
        if maxColumn - minColumn < 2 {
            return true
        }
        for index in minColumn+1...maxColumn-1 {
            if pieceAt(column: index, row: constant) != nil {
                return false
            }
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
            pieces.insert(ChessPiece(column: row * 7, row: 0, imageName: "Rook-black", isBlack: true, chessRank: .rook))
            pieces.insert(ChessPiece(column: row * 7, row: 7, imageName: "Rook-white", isBlack: false, chessRank: .rook))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 0, imageName: "Knight-black", isBlack: true, chessRank: .knight))
            pieces.insert(ChessPiece(column: 1 + row * 5, row: 7, imageName: "Knight-white", isBlack: false, chessRank: .knight))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 0, imageName: "Bishop-black", isBlack: true, chessRank: .bishop))
            pieces.insert(ChessPiece(column: 2 + row * 3, row: 7, imageName: "Bishop-white", isBlack: false, chessRank: .bishop))
        }
        
        pieces.insert(ChessPiece(column: 3, row: 0, imageName: "Queen-black", isBlack: true, chessRank: .queen))
        pieces.insert(ChessPiece(column: 3, row: 7, imageName: "Queen-white", isBlack: false, chessRank: .queen))
        pieces.insert(ChessPiece(column: 4, row: 0, imageName: "King-black", isBlack: true, chessRank: .king))
        pieces.insert(ChessPiece(column: 4, row: 7, imageName: "King-white", isBlack: false, chessRank: .king))
        
        for column in 0..<8 {
            pieces.insert(ChessPiece(column: column, row: 1, imageName: "Pawn-black", isBlack: true, chessRank: .pawn))
            pieces.insert(ChessPiece(column: column, row: 6, imageName: "Pawn-white", isBlack: false, chessRank: .pawn))
        }
    }
}

extension ChessEngine: CustomStringConvertible {
    var description: String {
        var description = ""
        
        description += "  0 1 2 3 4 5 6 7\n"
        for row in 0..<8 {
            description += "\(row)"
            for column in 0..<8 {
                if let chessPiece = pieceAt(column: column, row: row) {
                    switch chessPiece.chessRank {
                    case .king:
                        description += chessPiece.isBlack ? "K" : "k"
                        
                    case .queen:
                        description += chessPiece.isBlack ? "Q" : "q"
                        
                    case .pawn:
                        description += chessPiece.isBlack ? "P" : "p"
                        
                    case .bishop:
                        description += chessPiece.isBlack ? "B" : "b"
                        
                    case .knight:
                        description += chessPiece.isBlack ? "N" : "n"
                        
                    case .rook:
                        description += chessPiece.isBlack ? "R" : "r"
                    }
                } else {
                    description += " ."
                }
            }
            description += "\n"
        }
        
        return description
    }
}
