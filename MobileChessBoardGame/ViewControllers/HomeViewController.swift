//
//  HomeViewController.swift
//  MobileChessBoardGame
//
//  Created by Nikos Aggelidis on 7/11/21.
//  Copyright © 2021 NAPPS. All rights reserved.
//

import UIKit
import AVFoundation
import MultipeerConnectivity

class HomeViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var chessPieceTurnInfoLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var chessEngine = ChessEngine()
    
    var audioPlayer: AVAudioPlayer!
    
    var peerID: MCPeerID!
    var session: MCSession!
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peerConfiguration()
        audioPlayerConfiguration()
        chessEngine.initializeGame()
        boardViewConfiguration()
    }
    
    @IBAction func resetButtonTouchUpInside(_ sender: UIButton) {
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
    
    @IBAction func advertiseButtonTouchUpInside(_ sender: UIButton) {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "napps-chess")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }
    
    @IBAction func joinButtonTouchUpInside(_ sender: UIButton) {
        let browserViewController = MCBrowserViewController(serviceType: "napps-chess", session: session)
        browserViewController.delegate = self
        present(browserViewController, animated: true)
    }
}

extension HomeViewController: ChessDelegate {
    func movePiece(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        updateMove(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        let move = "\(fromColumn):\(fromRow):\(toColumn):\(toRow)"
        if let moveData = move.data(using: .utf8) {
            try? session.send(moveData, toPeers: session.connectedPeers, with: .reliable)
        }
    }
    
    func pieceAt(column: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(column: column, row: row)
    }
    
    func updateMove(fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int) {
        chessEngine.movePiece(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        audioPlayer.play()
        
        chessPieceTurnInfoLabel.text = chessEngine.blackTurn ? "Black's turn to move" : "White's turn to move"
    }
}

extension HomeViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            debugPrint("Not connected: \(peerID.displayName)")
            
        case .connecting:
            debugPrint("Connecting: \(peerID.displayName)")
            
        case .connected:
            debugPrint("Connected: \(peerID.displayName)")
            
        @unknown default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let move = String(data: data, encoding: .utf8) {
            let moveElements = move.components(separatedBy: ":")
            debugPrint(moveElements)
            if let fromColumn = Int(moveElements[0]), let fromRow = Int(moveElements[1]), let toColumn = Int(moveElements[2]), let toRow = Int(moveElements[3]) {
                DispatchQueue.main.async {
                    self.updateMove(fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow)
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

extension HomeViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
}

extension HomeViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

private extension HomeViewController {
    func peerConfiguration() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
    }
    
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
