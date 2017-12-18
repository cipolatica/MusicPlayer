//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Alberto Plata on 12/18/17.
//  Copyright © 2017 Alberto Plata. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreViewController: UIViewController {
    
    let musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    
    var hipHopButton: UIButton?
    var comedyButton: UIButton?
    var popButton: UIButton?
    var nextButton: UIButton?
    var stopButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hipHopButton = setupButton(with: "Hip-Hop/Rap", color: .green, textColor: .white)
        view.addSubview(hipHopButton!)
        
        comedyButton = setupButton(with: "Comedy", color: .green, textColor: .white)
        view.addSubview(comedyButton!)
        
        popButton = setupButton(with: "Pop", color: .green, textColor: .white)
        view.addSubview(popButton!)
        
        stopButton = setupButton(with: "Stop", color: .white, textColor: .green)
        view.addSubview(stopButton!)
        
        nextButton = setupButton(with: "Next", color: .white, textColor: .green)
        view.addSubview(nextButton!)
    }
    
    @objc func buttonTapped(button: UIButton) {
        
        if button === hipHopButton || button === comedyButton || button === popButton {
            
            MPMediaLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.play(genre: button.currentTitle!)
                }
            }
        }
        else if button === nextButton {
            musicPlayer.skipToNextItem()
        }
        else {
            musicPlayer.stop()
        }
    }
    
    private func play(genre: String) {
        
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
    }
    
    private func setupButton(with text:String, color:UIColor, textColor:UIColor) -> UIButton {
        
        let button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleShadowColor(color, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        return button
    }
    
    private func applyContstraints() {
        
        hipHopButton!.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        hipHopButton!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hipHopButton!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        hipHopButton!.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

}

