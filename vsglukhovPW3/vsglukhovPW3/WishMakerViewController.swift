//
//  ViewController.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit
import CoreData

// MARK: - WishMakerViewController class
class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {

    let slidersStack = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let hideButton: UIButton = UIButton(type: .system)
    let randomColorButton: UIButton = UIButton(type: .system)
    let colorPickerButton: UIButton = UIButton(type: .system)
    let showWishButton: UIButton = UIButton(type: .system)
    
    let sliderRed = CustomSlider(title: Constants.red, min: Constants.colorMin, max: Constants.colorMax)
    let sliderGreen = CustomSlider(title: Constants.green, min: Constants.colorMin, max: Constants.colorMax)
    let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.colorMin, max: Constants.colorMax)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        let color = UIColor(
            red: .random(in: Constants.colorMin...Constants.colorMax),
            green: .random(in: Constants.colorMin...Constants.colorMax),
            blue: .random(in: Constants.colorMin...Constants.colorMax),
            alpha: Constants.alphaValue
        )
        ChangeColors(color: color, sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue)
        
        configureTitle()
        configureDescription()
        configureButtons()
        configureSliders()
    }
    
    private func configureButtons() {
        configureShowWishButton()
        configureHideButton()
        configureRandomColorButton()
        configureColorPickerButton()
    }
    
    private func configureHideButton() {
        hideButton.setTitle(Constants.hideButtonTitle, for: .normal)
        hideButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.backgroundColor = Constants.viewColor
        hideButton.layer.cornerRadius = Constants.buttonsCornerRadius
        hideButton.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        
        view.addSubview(hideButton)
        hideButton.setHeight(Constants.buttonsHeightAnchor)
        hideButton.pinHorizontal(to: view, Constants.leadingAnchor)
        hideButton.pinBottom(to: showWishButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    private func configureRandomColorButton() {
        randomColorButton.setTitle(Constants.randomColorButtonTitle, for: .normal)
        randomColorButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.backgroundColor = Constants.viewColor
        randomColorButton.layer.cornerRadius = Constants.buttonsCornerRadius
        randomColorButton.addTarget(self, action: #selector(randomColorButtonPressed), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.setHeight(Constants.buttonsHeightAnchor)
        randomColorButton.pinHorizontal(to: view, Constants.leadingAnchor)
        randomColorButton.pinBottom(to: hideButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    private func configureColorPickerButton() {
        colorPickerButton.setTitle(Constants.colorPickerButtonTitle, for: .normal)
        colorPickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        colorPickerButton.setTitleColor(.black, for: .normal)
        colorPickerButton.backgroundColor = Constants.viewColor
        colorPickerButton.layer.cornerRadius = Constants.buttonsCornerRadius
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonPressed), for: .touchUpInside)
        
        view.addSubview(colorPickerButton)
        colorPickerButton.setHeight(Constants.buttonsHeightAnchor)
        colorPickerButton.pinHorizontal(to: view, Constants.leadingAnchor)
        colorPickerButton.pinBottom(to: randomColorButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    private func configureShowWishButton() {
        showWishButton.setTitle(Constants.showWishButtonTitle, for: .normal)
        showWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        showWishButton.setTitleColor(.black, for: .normal)
        showWishButton.backgroundColor = Constants.viewColor
        showWishButton.layer.cornerRadius = Constants.buttonsCornerRadius
        showWishButton.addTarget(self, action: #selector(showWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(showWishButton)
        showWishButton.setHeight(Constants.buttonsHeightAnchor)
        showWishButton.pinHorizontal(to: view, Constants.leadingAnchor)
        showWishButton.pinBottom(to: view.bottomAnchor, Constants.buttonsViewBottomAnchor)
    }
    
    private func configureTitle() {
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.viewColor
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTopAnchor)
    }
    
    private func configureDescription() {
        descriptionLabel.text = Constants.description
        descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.viewColor
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinCenterX(to: view)
        descriptionLabel.pinHorizontal(to: view, Constants.leadingAnchor)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTopAnchor)
    }
    
    private func configureSliders() {
        slidersStack.axis = .vertical
        slidersStack.layer.cornerRadius = Constants.slidersCornerRadius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slidersStack.addArrangedSubview(slider)
        }
        
        view.addSubview(slidersStack)
        slidersStack.pinCenterX(to: view)
        slidersStack.pinHorizontal(to: view, Constants.leadingAnchor)
        slidersStack.pinBottom(to: colorPickerButton.topAnchor, Constants.slidersBottomAnchor)
        
        sliderRed.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderGreen.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderBlue.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc
    private func showWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func hideButtonPressed() {
        self.slidersStack.isHidden = !self.slidersStack.isHidden
    }
    
    @objc
    private func randomColorButtonPressed() {
        let color = UIColor(
            red: .random(in: Constants.colorMin...Constants.colorMax),
            green: .random(in: Constants.colorMin...Constants.colorMax),
            blue: .random(in: Constants.colorMin...Constants.colorMax),
            alpha: Constants.alphaValue
        )
        
        UIView.animate(
            withDuration: Constants.randomColorAnimationDur,
            animations: {
                self.ChangeColors(color: color, sliderRed: self.sliderRed, sliderGreen: self.sliderGreen, sliderBlue: self.sliderBlue)
            },
            completion: { [weak self] _ in
                self?.randomColorButton.isEnabled = true
            }
        )
    }
    
    @objc
    private func colorPickerButtonPressed() {
        if #available(iOS 14.0, *) {
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            present(colorPicker, animated: true)
        } else { }
    }
    
    @available(iOS 14.0, *)
    internal func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        UIView.animate(withDuration: Constants.colorPickerAnimationDur) {
            self.ChangeColors(color: viewController.selectedColor, sliderRed: self.sliderRed, sliderGreen: self.sliderGreen, sliderBlue: self.sliderBlue)
        }
    }
    
    @objc
    private func sliderValueChanged() {
        let color = UIColor(red: CGFloat(self.sliderRed.slider.value), green: CGFloat(self.sliderGreen.slider.value), blue: CGFloat(self.sliderBlue.slider.value), alpha: Constants.alphaValue)
        self.ChangeColors(color: color, sliderRed: self.sliderRed, sliderGreen: self.sliderGreen, sliderBlue: self.sliderBlue)
    }
    
    public func getBackgroundColor() -> [CGFloat] {
        if let backgroundColor = view.backgroundColor {
            if let components = backgroundColor.cgColor.components {
                let red = components[Constants.redComponent]
                let green = components[Constants.greenComponent]
                let blue = components[Constants.blueComponent]
                return [red, green, blue]
            }
        }
        return [Constants.defaultComponent, Constants.defaultComponent, Constants.defaultComponent]
    }
    
    private func ChangeColors(color: UIColor, sliderRed: CustomSlider, sliderGreen: CustomSlider, sliderBlue: CustomSlider) {
        view.backgroundColor = color
        sliderRed.slider.minimumTrackTintColor = color
        sliderGreen.slider.minimumTrackTintColor = color
        sliderBlue.slider.minimumTrackTintColor = color
        
        let backgroundColorComponents = self.getBackgroundColor()
        self.sliderRed.slider.value = Float(backgroundColorComponents[Constants.redComponent])
        self.sliderGreen.slider.value = Float(backgroundColorComponents[Constants.greenComponent])
        self.sliderBlue.slider.value = Float(backgroundColorComponents[Constants.blueComponent])
    }
}

