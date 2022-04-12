//
//  UIView+Extension.swift
//  TheNews
//
//  Created by vtsyganov on 15.02.2022.
//

import UIKit

extension UIView {
    func anchor (
        top: NSLayoutYAxisAnchor?,
        left: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        right: NSLayoutXAxisAnchor?,
        paddingTop: CGFloat,
        paddingLeft: CGFloat,
        paddingBottom: CGFloat,
        paddingRight: CGFloat,
        width: CGFloat,
        height: CGFloat,
        enableInsets: Bool
    ) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
    func equalAnchorsTo(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension UIView {
    func roundedView(to cornerRadius: CGFloat, with corners: UIRectCorner = [.allCorners]) {
        guard !corners.isEmpty else {
            return
        }
        
        let corners = UIRectCorner(arrayLiteral: corners)
        
        let cornerRadii = CGSize(
            width: cornerRadius,
            height: cornerRadius
        )
        
        let maskPath = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = self.bounds
        
        self.layer.mask = maskLayer
    }
}

extension UIView {
    func blink(duration: TimeInterval, alphaMax: CGFloat = 1.0, alphaMin: CGFloat = 0.0, delay: TimeInterval = 0.0 ) {
        self.alpha = alphaMin
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = alphaMax },
            completion: { [weak self] _ in self?.alpha = alphaMin }
        )
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1.0
    }
}
