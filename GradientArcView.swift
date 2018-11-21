//
//  GradientArcView.swift
//
//  Created by dennisyu on 2/11/2018.
//

import UIKit

private extension CGFloat {
    var toRads: CGFloat { return self * CGFloat.pi / 180 }
}

@IBDesignable
class GradientArcView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.orange
    @IBInspectable var secondColor: UIColor = UIColor.orange

    @IBInspectable var ringThickness: CGFloat = 4

    @IBInspectable var startAngle: CGFloat = 0
    @IBInspectable var endAngle: CGFloat = 360
    
    @IBInspectable var fullCircle: Bool = true
    @IBInspectable var isSelected: Bool = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if (isSelected) { drawRingFittingInsideView(rect: rect) }
    }
    
    internal func drawRingFittingInsideView(rect: CGRect)->()
    {

        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))

        let gradient = CAGradientLayer()
        gradient.frame = path.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        
        let shapeMask = CAShapeLayer()
        
        let outerBorderWidth: CGFloat = 1
        
        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let offSet = max(ringThickness*2, ringThickness) / 2  + (outerBorderWidth*2)
        let outerRadius: CGFloat = min(bounds.width, bounds.height) / 2 - CGFloat(offSet)
        let start: CGFloat = fullCircle ? 0 : startAngle.toRads
        let end: CGFloat = fullCircle ? .pi * 2 : endAngle.toRads
        
        let path2 = UIBezierPath(arcCenter: center,
                                                 radius: outerRadius,
                                                 startAngle: start,
                                                 endAngle: end,
                                                 clockwise: true)
        
        shapeMask.path = path2.cgPath
        shapeMask.fillColor = UIColor.clear.cgColor
        shapeMask.strokeColor = firstColor.cgColor
        shapeMask.lineWidth = ringThickness
        shapeMask.contentsScale = layer.contentsScale
        gradient.mask = shapeMask
        
        layer.addSublayer(gradient)
    }

}
