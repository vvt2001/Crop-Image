//
//  CroppingLayerView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import UIKit

class CroppingLayerView: UIView {
    private var topEdgeIndicatorView = EdgeIndicatorView()
    private var rightEdgeIndicatorView = EdgeIndicatorView()
    private var bottomEdgeIndicatorView = EdgeIndicatorView()
    private var leftEdgeIndicatorView = EdgeIndicatorView()

    private var topLeftCornerIndicatorView = CornerIndicatorView()
    private var topRightCornerIndicatorView = CornerIndicatorView()
    private var bottomRightCornerIndicatorView = CornerIndicatorView()
    private var bottomLeftCornerIndicatorView = CornerIndicatorView()
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self)
        self.center.x += translation.x
        self.center.y += translation.y
        recognizer.setTranslation(.zero, in: self)
    }
    
    private func updateIndicatorView(){
        topEdgeIndicatorView.frame = CGRect(x: self.frame.width/2 - 6, y: -6, width: 12, height: 12)
        rightEdgeIndicatorView.frame = CGRect(x: self.frame.width - 6, y: self.frame.height/2 - 6, width: 12, height: 12)
        bottomEdgeIndicatorView.frame = CGRect(x: self.frame.width/2 - 6, y: self.frame.height - 6, width: 12, height: 12)
        leftEdgeIndicatorView.frame = CGRect(x: -6, y: self.frame.height/2 - 6, width: 12, height: 12)
        
        topLeftCornerIndicatorView.frame = CGRect(x: -12, y: -12, width: 24, height: 24)
        topRightCornerIndicatorView.frame = CGRect(x: self.frame.width - 12, y: -12, width: 24, height: 24)
        bottomRightCornerIndicatorView.frame = CGRect(x: self.frame.width - 12, y: self.frame.height - 12, width: 24, height: 24)
        bottomLeftCornerIndicatorView.frame = CGRect(x: -12, y: self.frame.height - 12, width: 24, height: 24)
    }
    
    private func setupView(){
        self.backgroundColor = UIColor.link.withAlphaComponent(0.2)
        
        topEdgeIndicatorView.delegate = self
        rightEdgeIndicatorView.delegate = self
        bottomEdgeIndicatorView.delegate = self
        leftEdgeIndicatorView.delegate = self
        
        topLeftCornerIndicatorView.delegate = self
        topRightCornerIndicatorView.delegate = self
        bottomRightCornerIndicatorView.delegate = self
        bottomLeftCornerIndicatorView.delegate = self
        
        self.addSubview(topEdgeIndicatorView)
        self.addSubview(rightEdgeIndicatorView)
        self.addSubview(bottomEdgeIndicatorView)
        self.addSubview(leftEdgeIndicatorView)

        self.addSubview(topLeftCornerIndicatorView)
        self.addSubview(topRightCornerIndicatorView)
        self.addSubview(bottomRightCornerIndicatorView)
        self.addSubview(bottomLeftCornerIndicatorView)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        updateIndicatorView()
    }
}

extension CroppingLayerView: EdgeIndicatorViewDelegate{
    func edgeIndicatorView(_ edgeIndicatorView: EdgeIndicatorView, didPanIndicatorWithRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: edgeIndicatorView)
        if edgeIndicatorView == leftEdgeIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x + translation.x, y: oldFrame.origin.y, width: oldFrame.width - translation.x, height: oldFrame.height)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: leftEdgeIndicatorView)
        }

        if edgeIndicatorView == topEdgeIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y + translation.y, width: oldFrame.width, height: oldFrame.height - translation.y)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: topEdgeIndicatorView)
        }

        if edgeIndicatorView == rightEdgeIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.width + translation.x, height: oldFrame.height)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: rightEdgeIndicatorView)
        }

        if edgeIndicatorView == bottomEdgeIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.width, height: oldFrame.height + translation.y)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: bottomEdgeIndicatorView)
        }
    }
}

extension CroppingLayerView: CornerIndicatorViewDelegate{
    func cornerIndicatorView(_ cornerIndicatorView: CornerIndicatorView, didPanIndicatorWithRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: cornerIndicatorView)
        if cornerIndicatorView == topLeftCornerIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x + translation.x, y: oldFrame.origin.y + translation.y, width: oldFrame.width - translation.x, height: oldFrame.height - translation.y)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: topLeftCornerIndicatorView)
        }
        if cornerIndicatorView == topRightCornerIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y + translation.y, width: oldFrame.width + translation.x, height: oldFrame.height - translation.y)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: topRightCornerIndicatorView)
        }
        if cornerIndicatorView == bottomRightCornerIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.width + translation.x, height: oldFrame.height + translation.y)
                self.updateIndicatorView()

            }
            recognizer.setTranslation(.zero, in: bottomRightCornerIndicatorView)
        }
        if cornerIndicatorView == bottomLeftCornerIndicatorView{
            CroppingLayerView.animate(withDuration: 0.01) {
                let oldFrame = self.frame
                self.frame = CGRect(x: oldFrame.origin.x + translation.x, y: oldFrame.origin.y, width: oldFrame.width - translation.x, height: oldFrame.height + translation.y)
                self.updateIndicatorView()
            }
            recognizer.setTranslation(.zero, in: bottomLeftCornerIndicatorView)
        }
    }
}
