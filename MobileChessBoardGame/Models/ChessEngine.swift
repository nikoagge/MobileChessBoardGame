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
    var lastChessPieceMove: ChessPieceMove?
    var whiteKingSideRookMoved = false
    var whiteKingMoved = false
    var whiteQueenSideRookMoved = false
    var blackKingSideRookMoved = false
    var blackKingMoved = false
    var blackQueenSideRookMoved = false
    
    mutating func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        guard let candidate = pieceAt(column: fromColumn, row: fromRow) else { return }
        
        if let target = pieceAt(column: toColumn, row: toRow) {
            if target.isBlack == candidate.isBlack {
                return
            }
            pieces.remove(target)
        }
        
        pieces.remove(candidate)
        let movedChessPiece = ChessPiece(column: toColumn, row: toRow, imageName: candidate.imageName, isBlack: candidate.isBlack, chessRank: candidate.chessRank)
        pieces.insert(movedChessPiece)
        
        if fromColumn == 4 && fromRow == 7 {
            whiteKingMoved = true
        }
        
        if fromColumn == 7 && fromRow == 7 {
            whiteKingSideRookMoved = true
        }
        
        if fromColumn == 0 && fromRow == 7 {
            whiteQueenSideRookMoved = true
        }
        
        if fromColumn == 4 && fromRow == 0 {
            blackKingMoved = true
        }
        
        if fromColumn == 7 && fromRow == 0 {
            blackKingSideRookMoved = true
        }
        
        if fromColumn == 0 && fromRow == 0 {
            blackQueenSideRookMoved = true
        }
        
        if candidate.chessRank == .king && fromColumn == 4 {
            let row = !candidate.isBlack ? 7 : 0
            if toColumn == 6 {
                if let rook = pieceAt(column: 7, row: row) {
                    pieces.remove(rook)
                    pieces.insert(ChessPiece(column: 5, row: row, imageName: rook.imageName, isBlack: rook.isBlack, chessRank: rook.chessRank))
                }
            } else if toColumn == 2 {
                if let rook = pieceAt(column: 0, row: row) {
                    pieces.remove(rook)
                    pieces.insert(ChessPiece(column: 3, row: row, imageName: rook.imageName, isBlack: rook.isBlack, chessRank: rook.chessRank))
                }
            }
        }
        
        if let lastChessPieceMove = lastChessPieceMove, let lastMovedPawn = pieceAt(column: lastChessPieceMove.toColumn, row: lastChessPieceMove.toRow), !lastMovedPawn.isBlack != !candidate.isBlack, candidate.chessRank == .pawn, lastMovedPawn.chessRank == .pawn, abs(fromColumn - toColumn) == 1 && abs(fromRow - toRow) == 1 {
            pieces.remove(lastMovedPawn)
        }
        lastChessPieceMove = ChessPieceMove(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        blackTurn = !blackTurn
    }
    
    func underThreatAt(column: Int, row: Int, whiteEnemy: Bool) -> Bool {
        for piece in pieces where !piece.isBlack == whiteEnemy {
            if canMoveNonKingPiece(fromColumn: piece.column, fromRow: piece.row, toColumn: column, toRow: row, isWhite: whiteEnemy) || canPawnAttack(fromColumn: piece.column, fromRow: piece.row, toColumn: column, toRow: row) {
                return true
            }
        }
        
        return false
    }
    
    func canMovePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, isWhite: Bool) -> Bool {
        guard toColumn >= 0 && toColumn <= 7 && toRow >= 0 && toRow <= 7, (fromColumn != toColumn || fromRow != toRow), let movingPiece = pieceAt(column: fromColumn, row: fromRow) else { return false }
        
        if movingPiece.chessRank == .king {
            return canKingMove(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        } else {
            return canMoveNonKingPiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow, isWhite: isWhite)
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
    
    func canKingMove(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        guard !underThreatAt(column: toColumn, row: toRow, whiteEnemy: blackTurn) else { return false }
        if canCastle(toColumn: toColumn, toRow: toRow) {
            return true
        }
        let deltaColumn = abs(fromColumn - toColumn)
        let deltaRow = abs(fromRow - toRow)
        return (deltaColumn == 1 || deltaRow == 1) && deltaColumn + deltaRow < 3
    }
    
    func canMoveNonKingPiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, isWhite: Bool) -> Bool {
        guard let movingPiece = pieceAt(column: fromColumn, row: fromRow) else { return false }
        
        if let target = pieceAt(column: toColumn, row: toRow), target.isBlack == movingPiece.isBlack {
            return false
        }
        
        switch movingPiece.chessRank {
        case .knight:
            return canMoveKnight(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .rook:
            return canMoveRook(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .bishop:
            return canMoveBishop(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .queen:
            return canMoveQueen(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
            
        case .king:
            return false
            
        case .pawn:
            return canPawnMove(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        }
    }
    
    func canCastle(toColumn: Int, toRow: Int) -> Bool {
        guard let piece = pieceAt(column: 4, row: toRow), piece.chessRank == .king, !piece.isBlack == !blackTurn, toRow == (!piece.isBlack ? 7 : 0) else { return false }
        
        let row = !blackTurn ? 7 : 0
        let kingSide = toColumn == 6
        let columns = kingSide ? 5...6 : 1...3
        
        guard emptyAndSafe(row: row, columns: columns, whiteEnemy: blackTurn), toColumn == (kingSide ? 6 : 2) else { return false }
        
        if !piece.isBlack && !whiteKingMoved {
            return kingSide ? !whiteKingSideRookMoved : !whiteQueenSideRookMoved
        } else if piece.isBlack && !blackKingMoved {
            return kingSide ? !blackKingSideRookMoved : !blackQueenSideRookMoved
        }
        
        return false
    }
    
    func emptyAndSafe(row: Int, columns: ClosedRange<Int>, whiteEnemy: Bool) -> Bool {
        return emptyAt(row: row, columns: columns) && safeAt(row: row, columns: columns, whiteEnemy: whiteEnemy)
    }
    
    func safeAt(row: Int, columns: ClosedRange<Int>, whiteEnemy: Bool) -> Bool {
        for column in columns {
            if underThreatAt(column: column, row: row, whiteEnemy: whiteEnemy) {
                return false
            }
        }
        
        return true
    }
    
    func emptyAt(row: Int, columns: ClosedRange<Int>) -> Bool {
        for column in columns {
            if pieceAt(column: column, row: row) != nil {
                return false
            }
        }
        
        return true
    }
    
    func canPawnMove(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        guard let movingPawn = pieceAt(column: fromColumn, row: fromRow) else { return false }
        if let target = pieceAt(column: toColumn, row: toRow), !target.isBlack {
            return canPawnAttack(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        } else if toColumn == fromColumn {
            if pieceAt(column: fromColumn, row: fromRow + (movingPawn.isBlack ? 1 : -1)) == nil  {
                return toRow == fromRow + (movingPawn.isBlack ? 1 : -1) || toRow == fromRow + (movingPawn.isBlack ? 2 : -2) && pieceAt(column: fromColumn, row: fromRow) == nil && fromRow == (!movingPawn.isBlack ? 6 : 1)
            }
        } else if let lastChessPieceMove = lastChessPieceMove, let enemyPawn = pieceAt(column: lastChessPieceMove.toColumn, row: lastChessPieceMove.toRow), enemyPawn.chessRank == .pawn && !enemyPawn.isBlack != !movingPawn.isBlack && enemyPawn.row == fromRow && enemyPawn.column == toColumn, abs(toColumn - fromColumn) == 1 {
            if !movingPawn.isBlack {
                return fromRow == 3 && toRow == 2 && lastChessPieceMove.fromRow == 1
            } else {
                return fromRow == 4 && toRow == 5 && lastChessPieceMove.fromRow == 6
            }
        }
        
        return false
    }
    
    func canPawnAttack(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) -> Bool {
        guard let movingPawn = pieceAt(column: fromColumn, row: fromRow) else { return false }

        return toRow == fromRow + (!movingPawn.isBlack ? -1 : 1) && abs(toColumn - fromColumn) == 1
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
        pieces.removeAll()
        blackTurn = false
        lastChessPieceMove = nil
        
        whiteKingSideRookMoved = false
        whiteKingMoved = false
        whiteQueenSideRookMoved = false
        blackKingSideRookMoved = false
        blackKingMoved = false
        blackQueenSideRookMoved = false
        
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
