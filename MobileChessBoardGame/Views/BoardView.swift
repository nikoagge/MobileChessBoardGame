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
    var chessDelegate: ChessDelegate? = nil
    var fromColumn: Int = -4
    var fromRow: Int = -13
    var movingImage: UIImage? = nil
    var movingPieceX: CGFloat = -4
    var movingPieceY: CGFloat = -4
    
    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1 - ratio) / 2
        originY = bounds.height * (1 - ratio) / 2
        drawBoard()
        drawPieces()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first!
        let fingerLocation = firstTouch.location(in: self)
        fromColumn = Int((fingerLocation.x - originX) / cellSide)
        fromRow = Int((fingerLocation.y - originY) / cellSide)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        movingPieceX = fingerLocation.x
        movingPieceY = fingerLocation.y
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first!
        let fingerLocation = firstTouch.location(in: self)
        let toColumn: Int = Int((fingerLocation.x - originX) / cellSide)
        let toRow: Int = Int((fingerLocation.y - originY) / cellSide)
        
        chessDelegate?.movePiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        movingImage = nil
    }
}

private extension BoardView {
    func drawPieces() {
        for shadowPiece in shadowPieces {
            let pieceImage = UIImage(named: shadowPiece.imageName)
            pieceImage?.draw(in: CGRect(x: originX + CGFloat(shadowPiece.column) * cellSide, y: originY + CGFloat(shadowPiece.row) * cellSide, width: cellSide, height: cellSide))
            movingImage?.draw(in: CGRect(x: movingPieceX - (cellSide / 2), y: movingPieceY - (cellSide / 2), width: cellSide, height: cellSide))
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
