//
//  ViewController.swift
//  MkvTest
//
//  Created by Vladyslav Lypskyi on 07/05/2018.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VLCMediaPlayerDelegate {
  
  @IBOutlet weak var mediaView: UIView!
  @IBOutlet weak var playButton: UIButton! {
    didSet {
      playButton.setBackgroundImage(UIColor.blue.solidImage(), for: .normal)
      playButton.setBackgroundImage(UIColor.blue.withAlphaComponent(0.9).solidImage(), for: .highlighted)
    }
  }
  
  private var mediaPlayer: VLCMediaPlayer!
  
  private var media: VLCMedia {
    let path = Bundle.main.path(forResource: "test1", ofType: "mkv")!
    return VLCMedia(path: path)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    mediaPlayer = VLCMediaPlayer()
    mediaPlayer.delegate = self
    mediaPlayer.drawable = mediaView
    mediaPlayer.media = media
    mediaPlayer.play()
  }
  
  func mediaPlayerStateChanged(_ aNotification: Notification!) {
    let title = mediaPlayer.isPlaying ? "Pause" : "Play"
    playButton.setTitle(title, for: .normal)
  }
  
  @IBAction func buttonClicked(_ sender: UIButton) {
    print(mediaPlayer.state.rawValue)
    if mediaPlayer.isPlaying {
      mediaPlayer.pause()
    } else {
      if mediaPlayer.state == .stopped {
        // Restart
        mediaPlayer.media = media
      }
      mediaPlayer.play()
    }
  }

}

extension UIColor {
  
  func solidImage() -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    self.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
}

