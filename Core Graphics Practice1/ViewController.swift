//
//  ViewController.swift
//  Core Graphics Practice1
//
//  Created by Caroline LaDouce on 9/23/21.


import UIKit

class ViewController: UIViewController {
    
    let counterView = CounterView()
    let counterLabel = UILabel()
    let sampleButton1 = SamplePushButton()
    var sampleButton2 = SamplePushButton()
    let backgroundView = BackgroundView(frame: UIScreen.main.bounds)
    let medalView = MedalView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        backgroundView.contentMode = UIView.ContentMode.scaleAspectFill
        
        view.addSubview(backgroundView)
        backgroundView.alpha = 0.5
        
        
        
        // Setup CounterView
        view.addSubview(counterView)
        counterView.backgroundColor = UIColor.clear
        counterView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        counterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        counterView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        counterView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        // Set up counterLabel
        view.addSubview(counterLabel)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        counterLabel.centerYAnchor.constraint(equalTo: counterView.centerYAnchor).isActive = true
        
        counterLabel.textColor = UIColor.blue
        counterLabel.text = "\(counterView.counter)"
        counterLabel.font = counterLabel.font.withSize(40)
        counterLabel.textAlignment = .center
        
        
        // Set up the plus button/sampleButton1
        view.addSubview(sampleButton1)
        sampleButton1.isAddButton = true
        sampleButton1.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        sampleButton1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sampleButton1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75).isActive = true
        sampleButton1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sampleButton1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Hookup the touch handler func
        sampleButton1.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        
        
        // Set up minus button/sampleButton2
        view.addSubview(sampleButton2)
        sampleButton2.isAddButton = false
        sampleButton2.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        sampleButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sampleButton2.topAnchor.constraint(equalTo: sampleButton1.bottomAnchor, constant: 50).isActive = true
        sampleButton2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sampleButton2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Hookup the touch handler func
        sampleButton2.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        
        
        view.addSubview(medalView)
        
        medalView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        medalView.centerXAnchor.constraint(equalTo: counterView.centerXAnchor).isActive = true
        medalView.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 25).isActive = true
        medalView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        medalView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        medalView.contentMode = .scaleAspectFit
        
        self.view = view
    } // End viewDidLoad
    
    
    
    func resetHandler() {
        counterView.counter = 0
        counterLabel.text = String(counterView.counter)
        medalDisappear()
    }
    
    
    func eightGlassesComplete() {
        let yayPopUp = UIAlertController(title: "YAY", message: "8 Glasses complete", preferredStyle: .alert)
        
        // Add dismiss option
        yayPopUp.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(yayPopUp, animated: true)
        
        // Add reset counter option
        yayPopUp.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { action in
            self.resetHandler()
        }))
        
        
        showMedal()
    }
    
    
    func showMedal() {
        medalView.showMedal(show: true)
    }
    
    
    func medalDisappear() {
        medalView.showMedal(show: false)
    }
    
    
    func rotateButton(_ button: UIButton) {
        let layer = button.layer
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotationAnimation.keyTimes = [0, 1]
        rotationAnimation.values = [0, CGFloat.pi]
        rotationAnimation.duration = 0.25
        layer.add(rotationAnimation, forKey: "transform.rotation")
    }
    
    
    // TOUCH HANDLERS
    @objc func plusButtonPressed() {
        
        counterView.counter += 1
        
        if counterView.counter == 8 {
            eightGlassesComplete()
            showMedal()
        }
        
        if counterView.counter >= 8 {
            counterView.counter = 8
        }
        
        rotateButton(sampleButton1)
        counterLabel.text = String(counterView.counter)
        
    }
    
    
    @objc func minusButtonPressed() {
        counterView.counter -= 1
        
        if counterView.counter <= 0 {
            counterView.counter = 0
        }
        
        rotateButton(sampleButton2)
        counterLabel.text = String(counterView.counter)
    }
    
    
    
    
}

