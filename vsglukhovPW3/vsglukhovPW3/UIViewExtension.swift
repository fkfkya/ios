//
//  UIViewExtension.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 16.03.2024.
//

import UIKit

// MARK: - Pin methods for UIView
extension UIView {
    enum ConstraintMode {
        case equal
        case greaterOrEqual
        case lessOrEqual
    }
    
// MARK: - Pin Methods
    @discardableResult
    func pinLeft(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, leadingAnchor, otherView.leadingAnchor, const)
    }

    @discardableResult
    func pinLeft(
        to anchor: NSLayoutXAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, leadingAnchor, anchor, const)
    }

    @discardableResult
    func pinRight(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, trailingAnchor, otherView.trailingAnchor, -1 * const)
    }

    @discardableResult
    func pinRight(
        to anchor: NSLayoutXAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, trailingAnchor, anchor, -1 * const)
    }

    @discardableResult
    func pinTop(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, topAnchor, otherView.topAnchor, const)
    }

    @discardableResult
    func pinTop(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, topAnchor, anchor, const)
    }

    @discardableResult
    func pinBottom(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, bottomAnchor, otherView.bottomAnchor, -1 * const)
    }

    @discardableResult
    func pinBottom(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, bottomAnchor, anchor, -1 * const)
    }

    //@discardableResult
    func pinCenter(to otherView: UIView) {
        pinConstraint(mode: .equal, centerXAnchor, otherView.centerXAnchor)
        pinConstraint(mode: .equal, centerYAnchor, otherView.centerYAnchor)
    }

    @discardableResult
    func pinCenterX(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, centerXAnchor, otherView.centerXAnchor, const)
    }

    @discardableResult
    func pinCenterX(
        to anchor: NSLayoutXAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, centerXAnchor, anchor, const)
    }

    @discardableResult
    func pinCenterY(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, centerYAnchor, otherView.centerYAnchor, const)
    }

    @discardableResult
    func pinCenterY(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, centerYAnchor, anchor, const)
    }

    @discardableResult
    func pinWidth(
        to otherView: UIView,
        _ mult: Double = 1,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, widthAnchor, otherView.widthAnchor, mult)
    }

    @discardableResult
    func pinWidth(
        to anchor: NSLayoutDimension,
        _ mult: Double = 1,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, widthAnchor, anchor, mult)
    }

    @discardableResult
    func setWidth(mode: ConstraintMode = .equal, _ const: Double) -> NSLayoutConstraint {
        pinDimension(mode: mode, widthAnchor, constant: const)
    }

    @discardableResult
    func pinHeight(
        to otherView: UIView,
        _ mult: Double = 1,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, heightAnchor, otherView.heightAnchor, mult)
    }

    @discardableResult
    func pinHeight(
        to anchor: NSLayoutDimension,
        _ mult: Double = 1,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        return pinConstraint(mode: mode, heightAnchor, anchor, mult)
    }

    @discardableResult
    func setHeight(mode: ConstraintMode = .equal, _ const: Double) -> NSLayoutConstraint {
        pinDimension(mode: mode, heightAnchor, constant: const)
    }

    // MARK: - Pin Util
    func pinHorizontal(
        to otherView: UIView,
        _ const: Double = 0,
        mode: ConstraintMode = .equal
    ) {
        pinLeft(to: otherView, const, mode)
        pinRight(to: otherView, const, mode)
    }

    func pinVertical(
        to otherView: UIView,
        _ const: Double = 0,
        mode: ConstraintMode = .equal
    ) {
        pinTop(to: otherView, const, mode)
        pinBottom(to: otherView, const, mode)
    }

    func pin(to otherView: UIView, _ const: Double = 0) {
        pinVertical(to: otherView, const)
        pinHorizontal(to: otherView, const)
    }

    // MARK: - Private
    @discardableResult
    private func pinConstraint<Axis: AnyObject, AnyAnchor: NSLayoutAnchor<Axis>>(
        mode: ConstraintMode,
        _ firstAnchor: AnyAnchor,
        _ secondAnchor: AnyAnchor,
        _ constant: Double = 0
    ) -> NSLayoutConstraint {
        let const = CGFloat(constant)
        let result: NSLayoutConstraint
        translatesAutoresizingMaskIntoConstraints = false
        switch mode {
        case .equal:
            result = firstAnchor.constraint(equalTo: secondAnchor, constant: const)
        case .greaterOrEqual:
            result = firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor, constant: const)
        case .lessOrEqual:
            result = firstAnchor.constraint(lessThanOrEqualTo: secondAnchor, constant: const)
        }

        result.isActive = true
        return result
    }

    @discardableResult
    private func pinConstraint(
        mode: ConstraintMode,
        _ firstAnchor: NSLayoutDimension,
        _ secondAnchor: NSLayoutDimension,
        _ multiplier: Double = 1
    ) -> NSLayoutConstraint {
        let mult = CGFloat(multiplier)
        let result: NSLayoutConstraint
        translatesAutoresizingMaskIntoConstraints = false
        switch mode {
        case .equal:
            result = firstAnchor.constraint(equalTo: secondAnchor, multiplier: mult)
        case .greaterOrEqual:
            result = firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor, multiplier: mult)
        case .lessOrEqual:
            result = firstAnchor.constraint(lessThanOrEqualTo: secondAnchor, multiplier: mult)
        }

        result.isActive = true
        return result
    }

    @discardableResult
    private func pinDimension(
        mode: ConstraintMode,
        _ dimension: NSLayoutDimension,
        constant: Double
    ) -> NSLayoutConstraint {
        let const = CGFloat(constant)
        let result: NSLayoutConstraint
        translatesAutoresizingMaskIntoConstraints = false
        switch mode {
        case .equal:
            result = dimension.constraint(equalToConstant: const)
        case .greaterOrEqual:
            result = dimension.constraint(greaterThanOrEqualToConstant: const)
        case .lessOrEqual:
            result = dimension.constraint(lessThanOrEqualToConstant: const)
        }

        result.isActive = true
        return result
    }
}

