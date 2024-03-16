//
//  ViewController.swift
//  vsglukhovPW2
//
//  Created by Valentin Glukhov on 16.03.2024.
//


import UIKit

// MARK: - CustomSlider class
final class CustomSlider: UIView {
    
    enum Constants {
        static let titleFontSize: CGFloat = 17
        static let titleTopAnchor: CGFloat = 15
        
        static let sliderCenterXAnchor: CGFloat = -10
        
        static let leadingAnchor: CGFloat = 25
        
        static let viewColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }
    
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

// MARK: - WishMakerViewController class
class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    enum Constants {
        static let colorMin: Double = 0
        static let colorMax: Double = 1
        static let alphaValue: Double = 1
        static let viewColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let redComponent: Int = 0
        static let greenComponent: Int = 1
        static let blueComponent: Int = 2
        static let defaultComponent: CGFloat = 0
        
        static let buttonsTitleFontSize: CGFloat = 17
        static let buttonsCornerRadius: CGFloat = 20
        static let buttonsHeightAnchor: CGFloat = 45
        static let buttonsViewBottomAnchor: CGFloat = -30
        static let buttonsBottomAnchor: CGFloat = -5
        
        static let hideButtonTitle: String = "Hide/show sliders"
        static let randomColorButtonTitle: String = "Random color"
        static let colorPickerButtonTitle: String = "Color picker"
        
        static let leadingAnchor: CGFloat = 20
        
        static let title: String = "Wish Maker"
        static let titleFontSize: CGFloat = 32
        static let titleTopAnchor: CGFloat = 30
        
        static let description: String =
        """
        This app will bring you joy and will fulfill three of your wishes!
            · First - change the background color
        To be continued...
        """
        static let descriptionNumberOfLines: Int = 0
        static let descriptionFontSize: CGFloat = 15
        static let descriptionTopAnchor: CGFloat = 10
        
        static let slidersCornerRadius: Double = 25
        static let slidersBottomAnchor: CGFloat = -5
        
        static let randomColorAnimationDur: Double = 0.3
        static let colorPickerAnimationDur: Double = 0.5
        
        
    }
    
    let slidersStack = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let hideButton = UIButton()
    let randomColorButton = UIButton()
    let colorPickerButton = UIButton()
    
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
        configureHideButton()
        configureRandomColorButton()
        configureColorPickerButton()
    }
    
    private func configureHideButton() {
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(Constants.hideButtonTitle, for: .normal)
        hideButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.backgroundColor = Constants.viewColor
        hideButton.layer.cornerRadius = Constants.buttonsCornerRadius
        hideButton.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        
        view.addSubview(hideButton)
        NSLayoutConstraint.activate([
            hideButton.heightAnchor.constraint(equalToConstant: Constants.buttonsHeightAnchor),
            hideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            hideButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.buttonsViewBottomAnchor)
        ])
    }
    
    private func configureRandomColorButton() {
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        randomColorButton.setTitle(Constants.randomColorButtonTitle, for: .normal)
        randomColorButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.backgroundColor = Constants.viewColor
        randomColorButton.layer.cornerRadius = Constants.buttonsCornerRadius
        randomColorButton.addTarget(self, action: #selector(randomColorButtonPressed), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        NSLayoutConstraint.activate([
            randomColorButton.heightAnchor.constraint(equalToConstant: Constants.buttonsHeightAnchor),
            randomColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            randomColorButton.bottomAnchor.constraint(equalTo: hideButton.topAnchor, constant: Constants.buttonsBottomAnchor),
        ])
    }
    
    private func configureColorPickerButton() {
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.setTitle(Constants.colorPickerButtonTitle, for: .normal)
        colorPickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        colorPickerButton.setTitleColor(.black, for: .normal)
        colorPickerButton.backgroundColor = Constants.viewColor
        colorPickerButton.layer.cornerRadius = Constants.buttonsCornerRadius
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonPressed), for: .touchUpInside)
        
        view.addSubview(colorPickerButton)
        NSLayoutConstraint.activate([
            colorPickerButton.heightAnchor.constraint(equalToConstant: Constants.buttonsHeightAnchor),
            colorPickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorPickerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            colorPickerButton.bottomAnchor.constraint(equalTo: randomColorButton.topAnchor, constant: Constants.buttonsBottomAnchor),
        ])
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.viewColor
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopAnchor),
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.description
        descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.viewColor
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTopAnchor),
        ])
    }

    private func configureSliders() {
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        view.addSubview(slidersStack)
        slidersStack.layer.cornerRadius = Constants.slidersCornerRadius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slidersStack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            slidersStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slidersStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            slidersStack.bottomAnchor.constraint(equalTo: colorPickerButton.topAnchor, constant: Constants.slidersBottomAnchor)
        ])
        
        sliderRed.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderGreen.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderBlue.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
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
        let color = UIColor(red: CGFloat(self.sliderRed.slider.value), green: CGFloat(self.sliderGreen.slider.value), blue: CGFloat(self.sliderBlue.slider.value), alpha: 1)
        self.ChangeColors(color: color, sliderRed: self.sliderRed, sliderGreen: self.sliderGreen, sliderBlue: self.sliderBlue)
    }
    
    private func getBackgroundColor() -> [CGFloat] {
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

