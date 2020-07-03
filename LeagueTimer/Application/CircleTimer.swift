//
//  CircleTimer.swift
//  CircleTimer
//

import Foundation
import UIKit

class CircleTimer: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var timerBorderColor: UIColor = UIColor(red: 0.648, green: 0.549, blue: 0.444, alpha: 1.0)
    var timerBackgroundColor: UIColor = UIColor.clear
    var timerFillColor: UIColor = UIColor(red: 0.023, green: 0.286, blue: 0.505, alpha: 0.9)
    var timerShadowOpacity: CGFloat = 0.25
    var ratioForShadowWidth: CGFloat = 1 / 20
    var ratioForBorderWidth: CGFloat = 1 / 20
    var ratioForTimerDiameter: CGFloat = 16 / 20
    var filledLayer: CALayer? = nil
    var timerLayer: CALayer? = nil
    var timerFillDiameter: CGFloat = 0
    
    
    func setUpBaseLayer() {
        let layer = self.layer
        layer.backgroundColor = timerBackgroundColor.cgColor
        let bWidth = bounds.width * ratioForBorderWidth
        layer.borderWidth = bWidth
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = self.timerBorderColor.cgColor
        layer.shadowOpacity = Float(self.timerShadowOpacity)
        layer.shadowRadius = self.frame.width * ratioForShadowWidth
        timerFillDiameter = self.frame.width * ratioForTimerDiameter
        
        self.contentMode = UIView.ContentMode.redraw
    }
    
    
    open func drawFilled() {
        clear()
        if filledLayer == nil {
            let parentLayer = self.layer
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = parentLayer.bounds
            circleLayer.position = CGPoint(x: parentLayer.bounds.midX, y: parentLayer.bounds.midY)
            let circleRadius = timerFillDiameter * 0.5
            let circleBounds = CGRect(x: parentLayer.bounds.midX - circleRadius, y: parentLayer.bounds.midY - circleRadius, width: timerFillDiameter, height: timerFillDiameter)
            circleLayer.fillColor = timerFillColor.cgColor
            circleLayer.path = UIBezierPath(ovalIn: circleBounds).cgPath
            
            parentLayer.addSublayer(circleLayer)
            filledLayer = circleLayer
        }
    }
    
    open func clear() {
        removeTimerLayer()
        removeFilledLayer()
    }
    
    open func startTimer(duration: CFTimeInterval) {
        drawFilled()
        runMaskAnimation(duration: duration)
    }
    
    open func runMaskAnimation(duration: CFTimeInterval) {
        
        if let parentLayer = filledLayer {
            let maskLayer = CAShapeLayer()
            maskLayer.frame = parentLayer.frame
            
            let circleRadius = timerFillDiameter * 0.5
            let circleHalfRadius = circleRadius * 0.5
            let circleBounds = CGRect(x: parentLayer.bounds.midX - circleHalfRadius, y: parentLayer.bounds.midY - circleHalfRadius, width: circleRadius, height: circleRadius)
            
            maskLayer.fillColor = UIColor.clear.cgColor
            maskLayer.strokeColor = UIColor.black.cgColor
            maskLayer.lineWidth = circleRadius
            
            let path = UIBezierPath(roundedRect: circleBounds, cornerRadius: circleBounds.size.width * 0.5)
            maskLayer.path = path.reversing().cgPath
            maskLayer.strokeEnd = 0
            
            parentLayer.mask = maskLayer
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = 1.0
            animation.toValue = 0.0
            maskLayer.add(animation, forKey: "strokeEnd")
        }
        
    }
    
    private func removeTimerLayer() {
        if let layer = timerLayer {
            layer.removeFromSuperlayer()
            timerLayer = nil
        }
    }
    
    private func removeFilledLayer() {
        if let layer = filledLayer {
            layer.removeFromSuperlayer()
            filledLayer = nil
        }
    }
    
    open func redraw() {
        timerLayer?.setNeedsDisplay()
        filledLayer?.setNeedsDisplay()
        self.layer.setNeedsDisplay()
    }
    
    
}
