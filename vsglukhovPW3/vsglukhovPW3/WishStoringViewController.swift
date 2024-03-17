//
//  WishStoringViewController.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit
import CoreData

final class WishStoringViewController: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate {
    
    private let wishMakerView = WishMakerViewController()
    private let table: UITableView = UITableView(frame: .zero)
    
    private var editingRow: Int = Constants.defaultEditingRowFlag
    
    let addWishTextField: UITextField = UITextField()
    let addWishButton: UIButton = UIButton(type: .system)
    let clearTableButton: UIButton = UIButton(type: .system)
    
    var wraps: [UIView] = []
    
    @available(iOS 15.0, *)
    var wishStoringController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        view.backgroundColor = generateRandomColor()
        
        if #available(iOS 15.0, *) {
            sheetPresentationController?.delegate = self
            sheetPresentationController?.prefersGrabberVisible = true
        }
        
        addWishTextField.delegate = self
        
        configureAddWishTextField()
        configureAddWishButton()
        configureClearTableButton()
        configureTable()
    }
    
    private func configureAddWishTextField() {
        let editingRowBool = editingRow != Constants.defaultEditingRowFlag
        
        addWishTextField.attributedPlaceholder = NSAttributedString(
            string: editingRowBool ? Constants.editWishTextFieldPlaceholder : Constants.addWishTextFieldPlaceholder,
            attributes: [.foregroundColor: UIColor.gray])
        addWishTextField.textColor = .black
        addWishTextField.textAlignment = .center
        addWishTextField.backgroundColor = Constants.viewColor
        addWishTextField.layer.cornerRadius = Constants.buttonsCornerRadius
        
        view.addSubview(addWishTextField)
    
        addWishTextField.setHeight(Constants.buttonsHeightAnchor)
        addWishTextField.pinHorizontal(to: view, Constants.leadingAnchor)
        addWishTextField.pinTop(to: view.topAnchor, Constants.titleTopAnchor)
    }
    
    private func configureAddWishButton() {
        let editingRowBool = editingRow != Constants.defaultEditingRowFlag
        
        addWishButton.setTitle(editingRowBool ? Constants.editWishButtonTitle : Constants.addWishButtonTitle, for: .normal)
        addWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        addWishButton.setTitleColor(.black, for: .normal)
        addWishButton.backgroundColor = Constants.viewColor
        addWishButton.layer.cornerRadius = Constants.buttonsCornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonsHeightAnchor)
        addWishButton.pinHorizontal(to: view, Constants.leadingAnchor)
        addWishButton.pinTop(to: addWishTextField.bottomAnchor, Constants.buttonsBottomAnchor)
    }
    
    private func configureClearTableButton() {
        clearTableButton.setTitle(Constants.clearTableButtonTitle, for: .normal)
        clearTableButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        clearTableButton.setTitleColor(.black, for: .normal)
        clearTableButton.backgroundColor = Constants.viewColor
        clearTableButton.layer.cornerRadius = Constants.buttonsCornerRadius
        clearTableButton.addTarget(self, action: #selector(clearTableButtonPressed), for: .touchUpInside)
        
        view.addSubview(clearTableButton)
        clearTableButton.setHeight(Constants.buttonsHeightAnchor)
        clearTableButton.pinHorizontal(to: view, Constants.leadingAnchor)
        clearTableButton.pinTop(to: addWishButton.bottomAnchor, Constants.buttonsBottomAnchor)
    }
    
    private func configureTable() {
        table.backgroundColor = view.backgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        view.addSubview(table)
        table.pinTop(to: clearTableButton.bottomAnchor, Constants.tableTopAnchor)
        table.pinBottom(to: view.bottomAnchor, Constants.tableBottomAnchor)
        table.pinHorizontal(to: view, Constants.tableHOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
    
    @objc
    private func clearTableButtonPressed() {
        if CoreDataManager.shared.fetchWishes().count != 0 {
            editingRow = Constants.defaultEditingRowFlag
            
            configureAddWishTextField()
            configureAddWishButton()
            
            CoreDataManager.shared.deleteAllWishes()
            table.reloadData()
        }
    }
    
    @objc
    private func addWishButtonPressed() {
        let textFieldText: String = addWishTextField.text!
        if textFieldText != Constants.defaultWishTextField {
            if editingRow != Constants.defaultEditingRowFlag {
                CoreDataManager.shared.updateWish(text: textFieldText, id: Int32(editingRow))
                editingRow = Constants.defaultEditingRowFlag
            } else {
                CoreDataManager.shared.createWish(text: textFieldText,
                                                  id: Int32(table.numberOfRows(inSection: Constants.section)))
            }
            
            configureAddWishTextField()
            configureAddWishButton()
            
            addWishTextField.text = Constants.defaultWishTextField

            table.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func deleteRow(rowIndex: Int) {
        editingRow = Constants.defaultEditingRowFlag
        
        configureAddWishTextField()
        configureAddWishButton()
        
        print(rowIndex)
        CoreDataManager.shared.deleteWish(id: Int32(rowIndex))
        table.reloadData()
    }
    
    func editRow(rowIndex: Int) {
        editingRow = rowIndex
        
        configureAddWishTextField()
        configureAddWishButton()
        
        addWishTextField.text = Constants.defaultWishTextField
        table.reloadData()
    }
}

private func generateRandomColor() -> UIColor {
    return UIColor(
        red: .random(in: Constants.colorMin...Constants.colorMax),
        green: .random(in: Constants.colorMin...Constants.colorMax),
        blue: .random(in: Constants.colorMin...Constants.colorMax),
        alpha: Constants.alphaValue
    )
}

// MARK: - Extension for class
extension WishStoringViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.fetchWishes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wraps.append(wishCell.wrap)
        
        wishCell.deleteButtonTapAction = { [weak self] in
            self?.deleteRow(rowIndex: indexPath.row)
        }
        wishCell.editButtonTapAction = { [weak self] in
            self?.editRow(rowIndex: indexPath.row)
        }
        
        wishCell.configure(wish: CoreDataManager.shared.fetchWishes()[indexPath.row], rowIndex: indexPath.row)
        
        return wishCell
    }
}

