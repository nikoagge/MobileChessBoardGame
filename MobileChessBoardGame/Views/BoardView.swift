//
//  BoardView.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 7/11/21.
//

import UIKit

class BoardView: UIView {
    let ratio: CGFloat = 0.8
    var originX: CGFloat = -31
    var originY: CGFloat = -4
    var cellSide: CGFloat = -13
    var shadowPieces = Set<ChessPiece>()
    
    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1 - ratio) / 2
        originY = bounds.height * (1 - ratio) / 2
        drawBoard()
        drawPieces()
    }
}

private extension BoardView {
    func drawPieces() {
        for shadowPiece in shadowPieces {
            let pieceImage = UIImage(named: shadowPiece.imageName)
            pieceImage?.draw(in: CGRect(x: originX + CGFloat(shadowPiece.column) * cellSide, y: originY + CGFloat(shadowPiece.row) * cellSide, width: cellSide, height: cellSide))
        }
    }
    
    func drawBoard() {
        for row in 0..<4 {
            for column in 0..<4 {
                drawSquare(column: column * 2, row: row * 2, color: .yellow)
                drawSquare(column: 1 + column * 2, row: row * 2, color: .black)
                drawSquare(column: column * 2, row: 1 + row * 2, color: .black)
                drawSquare(column: 1 + column * 2, row: 1 + row * 2, color: .yellow)
            }
        }
    }
    
    func drawSquare(column: Int, row: Int, color: UIColor) {
        let bezierPath = UIBezierPath(rect: CGRect(x: originX + CGFloat(column) * cellSide, y: originY + CGFloat(row) * cellSide, width: cellSide, height: cellSide))
        color.setFill()
        bezierPath.fill()
    }
}
