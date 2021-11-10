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
        boardView.shadowPieces = chessEngine.pieces
    }
}
