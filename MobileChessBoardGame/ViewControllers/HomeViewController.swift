//
//  HomeViewController.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 7/11/21.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var chessPieceTurnInfoLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var chessEngine = ChessEngine()
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayerConfiguration()
        chessEngine.initializeGame()
        boardViewConfiguration()
    }
    
    @IBAction func resetButtonTouchUpInside(_ sender: UIButton) {
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
}

extension HomeViewController: ChessDelegate {
    func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        chessEngine.movePiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        audioPlayer.play()
        
        chessPieceTurnInfoLabel.text = chessEngine.blackTurn ? "Black's turn to move" : "White's turn to move"
    }
    
    func pieceAt(column: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(column: column, row: row)
    }
}

private extension HomeViewController {
    func audioPlayerConfiguration() {
        let url = Bundle.main.url(forResource: "chess-move", withExtension: "wav")!
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
    }
    
    func boardViewConfiguration() {
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        boardView.chessDelegate = self
        chessPieceTurnInfoLabel.text = "White's turn to move"
    }
}
