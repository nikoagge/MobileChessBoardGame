//
//  HomeViewController.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 7/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    
    var chessEngine = ChessEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chessEngine.initializeGame()
        boardViewConfiguration()
    }
}

extension HomeViewController: ChessDelegate {
    func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        chessEngine.movePiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
    
    func pieceAt(column: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(column: column, row: row)
    }
}

private extension HomeViewController {
    func boardViewConfiguration() {
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        boardView.chessDelegate = self
    }
}
