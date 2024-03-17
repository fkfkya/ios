//
//  CustomSliderView.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit

// MARK: - CustomSlider class
final class CustomSlider: UIView {
    
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - Constructor
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        configureUI()
    }
    
    // MARK: - Functions
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.viewColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleTopAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingAnchor),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderCenterXAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingAnchor)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
         valueChanged?(Double(slider.value))
    }
}
