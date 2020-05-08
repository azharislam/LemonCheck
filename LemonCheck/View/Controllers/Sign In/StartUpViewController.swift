//
//  StartUpViewController.swift
//  LemonCheck
//
//  Created by Azhar Islam on 08/05/2020.
//  Copyright © 2020 Varley Parker. All rights reserved.
//

import UIKit
import AVKit

class StartUpViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    private var videoPlayer: AVPlayer?
    private var videoPlayerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpElements()
    }

    override func viewWillAppear(_ animated: Bool) {
//        setUpVideo()
    }

    private func setUpElements() {
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)
    }

    func setUpVideo() {
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: Constants.Media.introVideo, ofType: Constants.Media.format)

        guard bundlePath != nil else {
            return
        }

        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)

        // Create the video player item
        let item = AVPlayerItem(url: url)

        // Create the player
        videoPlayer = AVPlayer(playerItem: item)

        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)

        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)

        view.layer.insertSublayer(videoPlayerLayer!, at: 0)

        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 1)
    }

}
