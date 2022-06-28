//
//  CornerIndicatorView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import Foundation
import UIKit

class CornerIndicatorView: UIView {
    
    private var shapeLayer = CAShapeLayer()
    weak var delegate: CornerIndicatorViewDelegate?
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        delegate?.cornerIndicatorView(self, didPanIndicatorWithTranslation: recognizer.translation(in: self))
        recognizer.setTranslation(.zero, in: self)
    }
    
    private func drawCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: self.frame.width/2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circlePath.cgPath
            
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.link.cgColor
        shapeLayer.lineWidth = self.frame.width/3
    }
    
    private func createView() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        self.backgroundColor = UIColor.white
        self.layer.insertSublayer(shapeLayer, at: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.width/2
        drawCircle()
    }
}

protocol CornerIndicatorViewDelegate: AnyObject {
    func cornerIndicatorView(_ cornerIndicatorView: CornerIndicatorView, didPanIndicatorWithTranslation translation: CGPoint)
}
