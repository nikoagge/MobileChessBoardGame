//
//  BoardView.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 7/11/21.
//

import UIKit

class BoardView: UIView {
    let originX: CGFloat = 24
    let originY: CGFloat = 38
    let cellSide: CGFloat = 42
    
    override func draw(_ rect: CGRect) {
        drawBoard()
    }
}

private extension BoardView {
    func drawBoard() {
        drawSquare(column: 0, row: 0, color: .white)
        drawSquare(column: 1, row: 0, color: .black)
    }
    
    func drawSquare(column: Int, row: Int, color: UIColor) {
        let bezierPath = UIBezierPath(rect: CGRect(x: originX + CGFloat(column) * cellSide, y: originY + CGFloat(row) * cellSide, width: cellSide, height: cellSide))
        color.setFill()
        bezierPath.fill()
    }
}
