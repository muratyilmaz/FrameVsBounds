//
//  ViewController.swift
//  frameVsBounds
//
//  Created by test on 06/10/2017.
//  Copyright © 2017 Grey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray
        view.clipsToBounds = true
        return view
    }()
    
    let imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 10, y: 10, width: 200, height: 200) )
        imgView.image = #imageLiteral(resourceName: "cover_eng")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout () {
        
        
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        
        

        let sliders = [
            getSliderWithLabel(id: "frameX", labelText: "Frame X", minVal: 0, maxVal: 100),
            getSliderWithLabel(id: "frameY", labelText: "Frame Y", minVal: 0, maxVal: 100),
            getSliderWithLabel(id: "boundX", labelText: "Bound X", minVal: 0, maxVal: 100),
            getSliderWithLabel(id: "boundY", labelText: "Bound Y", minVal: 0, maxVal: 100)
        ]
        
        let sliderStack = UIStackView(arrangedSubviews: sliders )
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        sliderStack.distribution = .fillEqually
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor ),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor ),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            sliderStack.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10 ),
            sliderStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            sliderStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            sliderStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        printFrameAndBound()
    }
    
    @objc func valueChanged(sender: UISlider) {
        
        guard let id = sender.accessibilityIdentifier else { return }
        
        switch id {
            case "frameX":
                var newOrigin = containerView.frame.origin
                newOrigin.x = CGFloat( sender.value )
                containerView.frame.origin = newOrigin
            case "frameY":
                var newOrigin = containerView.frame.origin
                newOrigin.y = CGFloat( sender.value )
                containerView.frame.origin = newOrigin
            case "boundX":
                var newOrigin = containerView.bounds.origin
                newOrigin.x = CGFloat( sender.value )
                containerView.bounds.origin = newOrigin
            case "boundY":
                var newOrigin = containerView.bounds.origin
                newOrigin.y = CGFloat( sender.value )
                containerView.bounds.origin = newOrigin
        default:
            print("unknown slider")
        }
        
        printFrameAndBound()
        
    }
    
    func printFrameAndBound(){
        print("frame: \(containerView.frame)::: bound\(containerView.bounds)")
    }
    
    func getSliderWithLabel(id: String, labelText: String, minVal: Float, maxVal: Float) -> UIStackView {
        
        let slider = UISlider()
        slider.accessibilityIdentifier = id
        slider.minimumValue = minVal
        slider.maximumValue = maxVal
        slider.addTarget(self, action: #selector(self.valueChanged(sender:)), for: .valueChanged)
        
        let label = UILabel()
        label.text = labelText

        let stackView = UIStackView(arrangedSubviews: [label, slider])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }
}

