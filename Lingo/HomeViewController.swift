//
//  HomeViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 30.01.2026.
//

import Foundation
import UIKit
final class HomeViewController:UIViewController{
    private let backgroundImageView = UIImageView() //duvar kagıdı
    private let dimOverlayView = UIView() //karartma perdesi
    private let logoImageView = UIImageView()
    private let playButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupBackground()
        setupLogo()
        setupPlayButton()
    }
    @objc private func playTapped() {
        let gameVC = ViewController() // senin mevcut oyun ekranın
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
    }
 

    private func setupPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("PLAY", for: .normal)
        playButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .black)
        playButton.setTitleColor(.white, for: .normal)

        playButton.backgroundColor = UIColor.systemYellow
        playButton.layer.cornerRadius = 28

        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOpacity = 0.4
        playButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        playButton.layer.shadowRadius = 12

        view.addSubview(playButton)

        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        playButton.addTarget(
            self,
            action: #selector(playTapped),
            for: .touchUpInside
        )

    }

    private func setupLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo_bingo")
        logoImageView.contentMode = .scaleAspectFit

        logoImageView.layer.shadowColor = UIColor.black.cgColor
        logoImageView.layer.shadowOpacity = 0.6
        logoImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoImageView.layer.shadowRadius = 10

        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 500),
            logoImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }


    private func setupBackground() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "home_bg")
        backgroundImageView.contentMode = .scaleAspectFill

        view.addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        dimOverlayView.translatesAutoresizingMaskIntoConstraints = false
        dimOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.25)

        view.addSubview(dimOverlayView)

        NSLayoutConstraint.activate([
            dimOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            dimOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }

    
}
