//
//  ChessDelegate.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 11/11/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import Foundation

protocol ChessDelegate {
    func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int)
    func pieceAt(column: Int, row: Int) -> ChessPiece?
}
