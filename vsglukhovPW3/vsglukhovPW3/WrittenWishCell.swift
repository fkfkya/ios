//
//  WrittenWishCell.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit

// MARK: - WrittenWishCell class
final class WrittenWishCell: UITableViewCell {
    
    static let reuseId: String = Constants.wishCellReuseId
    private let wishLabel: UILabel = UILabel()
    private let wishDeleteButton: UIButton = UIButton()
    private let wishEditButton: UIButton = UIButton()
    
    private let wishStoringView = WishStoringViewController()
        
    var deleteButtonTapAction: (() -> Void)?
    var editButtonTapAction: (() -> Void)?
    
    let wrap: UIView = UIView()
    
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.wishCellError)
    }
    
    // MARK: - Functions
    func configure(wish: Wish, rowIndex: Int) {
        wishLabel.text = wish.wish
        wishLabel.textColor = .black
        
        wishDeleteButton.setImage(UIImage(systemName: Constants.wishDeleteIcon)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        wishDeleteButton.setTitleColor(.white, for: .normal)
        wishDeleteButton.addTarget(self, action: #selector(wishDeleteButtonPressed), for: .touchUpInside)
        wishDeleteButton.tag = rowIndex
        
        wishEditButton.setImage(UIImage(systemName: Constants.wishEditIcon), for: .normal)
        wishEditButton.setTitleColor(.white, for: .normal)
        wishEditButton.addTarget(self, action: #selector(wishEditButtonPressed), for: .touchUpInside)
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear

        wrap.backgroundColor = .white
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        contentView.addSubview(wrap)
        wrap.pinHorizontal(to: self, Constants.wrapHOffset)
        wrap.pinTop(to: self, Constants.wrapTopAnchor)
        
        wrap.addSubview(wishDeleteButton)
        wishDeleteButton.pinRight(to: wrap.trailingAnchor, Constants.wishDeleteButtonRightAnchor)
        wishDeleteButton.pinCenterY(to: wrap)
        
        wrap.addSubview(wishEditButton)
        wishEditButton.pinRight(to: wishDeleteButton.leadingAnchor, Constants.wishEditButtonRightAnchor)
        wishEditButton.pinCenterY(to: wrap)
        
        wrap.addSubview(wishLabel)
        wishLabel.pinVertical(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinLeft(to: wrap.leadingAnchor, Constants.wishLabelLeftAnchor)
        wishLabel.pinRight(to: wrap.trailingAnchor, Constants.wishLabelRightAnchor)
    }
    
    @objc
    private func wishDeleteButtonPressed() {
        deleteButtonTapAction?()
    }
    
    @objc
    private func wishEditButtonPressed() {
        editButtonTapAction?()
    }
}

