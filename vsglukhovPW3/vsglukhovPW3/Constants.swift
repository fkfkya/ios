//
//  Constants.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit

// MARK: - Used Constants
enum Constants {
    static let section: Int = 0
    
    static let sliderTitleFontSize: CGFloat = 17
    static let sliderTitleTopAnchor: CGFloat = 15
    
    static let sliderCenterXAnchor: CGFloat = -10
    
    static let sliderLeadingAnchor: CGFloat = 25
    
    static let viewColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    
    static let colorMin: Double = 0
    static let colorMax: Double = 1
    static let alphaValue: Double = 1
    
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
    static let buttonsViewBottomAnchor: CGFloat = 30
    static let buttonsBottomAnchor: CGFloat = 5
    
    static let hideButtonTitle: String = "Hide/show sliders"
    static let randomColorButtonTitle: String = "Random color"
    static let colorPickerButtonTitle: String = "Color picker"
    static let showWishButtonTitle: String = "My wishes"
    static let addWishButtonTitle: String = "Add"
    static let editWishButtonTitle: String = "Edit"
    static let clearTableButtonTitle: String = "Clear all"
    
    static let leadingAnchor: CGFloat = 20
    
    static let title: String = "Wish Maker"
    static let titleFontSize: CGFloat = 32
    static let titleTopAnchor: CGFloat = 15
    
    static let description: String =
    """
        This app will bring you joy and will fulfill three of your wishes!
            · First - change the background color
            · Second - add and edit list of your wishes
    
        To be continued...
    """
    static let descriptionNumberOfLines: Int = 0
    static let descriptionFontSize: CGFloat = 15
    static let descriptionTopAnchor: CGFloat = 10
    
    static let slidersCornerRadius: Double = 25
    static let slidersBottomAnchor: CGFloat = 5
    
    static let randomColorAnimationDur: Double = 0.3
    static let colorPickerAnimationDur: Double = 0.5
    
    static let wrapColor: UIColor = Constants.viewColor
    static let wrapRadius: CGFloat = 17
    static let wrapOffsetV: CGFloat = 5
    static let wrapOffsetH: CGFloat = 10
    static let wishLabelOffset: CGFloat = 10
    
    static let wishArrayKey: String = "wishArray"
    
    static let defaultWishTextField: String = ""
    static let editWishTextFieldPlaceholder: String = "Edit"
    static let addWishTextFieldPlaceholder: String = "Input"
    
    static let wrapHOffset: CGFloat = 10
    static let wrapTopAnchor: CGFloat = 15
    
    static let wishCellReuseId: String = "WrittenWishCell"
    static let wishCellError: String = "init(coder:) has not been implemented"
    
    static let wishDeleteButtonRightAnchor: CGFloat = 10
    static let wishEditButtonRightAnchor: CGFloat = 5
    
    static let wishDeleteIcon: String = "multiply.circle.fill"
    static let wishEditIcon: String = "pencil.circle"
    
    static let wishLabelLeftAnchor: CGFloat = 10
    static let wishLabelRightAnchor: CGFloat = 50
    
    static let tableCornerRadius: CGFloat = 25
    static let tableTopAnchor: CGFloat = 5
    static let tableBottomAnchor: CGFloat = 0
    static let tableHOffset: CGFloat = 10
    
    
    static let defaultEditingRowFlag: Int = -1
}

