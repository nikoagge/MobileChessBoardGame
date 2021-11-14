//
//  ChessPiece.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 10/11/21.
//

import Foundation

struct ChessPiece: Hashable {
    let column: Int
    let row: Int
    let imageName: String
    let isBlack: Bool
}
