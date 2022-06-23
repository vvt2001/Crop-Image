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
    
    private let edgeIndicatorSize = CGSize(width: 16, height: 16)
    private let cornerIndicatorSize = CGSize(width: 24, height: 24)
    
    weak var delegate: CroppingLayerViewDelegate?

    private func limitedCroppingLayerRect(frame: CGRect) -> CGRect {
        guard let superviewFrame = self.superview?.bounds else { return CGRect() }
        var newFrame = frame
        
        // make sure Left edge is not past Left edge of superview
        newFrame.origin.x = max(newFrame.origin.x, 0.0)
        // make sure Right edge is not past Right edge of superview
        newFrame.origin.x = min(newFrame.origin.x, superviewFrame.size.width - newFrame.size.width)
        // make sure Top edge is not past Top edge of superview
        newFrame.origin.y = max(newFrame.origin.y, 0.0)
        // make sure Bottom edge is not past Bottom edge of superview
        newFrame.origin.y = min(newFrame.origin.y, superviewFrame.size.height - newFrame.size.height)
        
        return newFrame
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        self.center.x += translation.x
        self.center.y += translation.y
        
        // new frame for this "draggable" subview, based on touch offset when moving
        var newFrame = self.frame.offsetBy(dx: translation.x, dy: translation.y)
        newFrame = limitedCroppingLayerRect(frame: newFrame)

        self.frame = newFrame
        recognizer.setTranslation(.zero, in: self)
        self.delegate?.croppingLayerViewChanged(self)
    }
    
    private func updateIndicatorViewLayout() {
        topEdgeIndicatorView.frame.origin = CGPoint(x: self.frame.width/2 - edgeIndicatorSize.width/2, y: -edgeIndicatorSize.height/2)
        rightEdgeIndicatorView.frame.origin = CGPoint(x: self.frame.width - edgeIndicatorSize.width/2, y: self.frame.height/2 - edgeIndicatorSize.height/2)
        bottomEdgeIndicatorView.frame.origin = CGPoint(x: self.frame.width/2 - edgeIndicatorSize.width/2, y: self.frame.height - edgeIndicatorSize.height/2)
        leftEdgeIndicatorView.frame.origin = CGPoint(x: -edgeIndicatorSize.width/2, y: self.frame.height/2 - edgeIndicatorSize.height/2)
        
        topLeftCornerIndicatorView.frame.origin = CGPoint(x: -cornerIndicatorSize.width/2, y: -cornerIndicatorSize.height/2)
        topRightCornerIndicatorView.frame.origin = CGPoint(x: self.frame.width - cornerIndicatorSize.width/2, y: -cornerIndicatorSize.height/2)
        bottomRightCornerIndicatorView.frame.origin = CGPoint(x: self.frame.width - cornerIndicatorSize.width/2, y: self.frame.height - cornerIndicatorSize.height/2)
        bottomLeftCornerIndicatorView.frame.origin = CGPoint(x: -cornerIndicatorSize.width/2, y: self.frame.height - cornerIndicatorSize.height/2)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.link.withAlphaComponent(0.2)
        
        topEdgeIndicatorView.delegate = self
        rightEdgeIndicatorView.delegate = self
        bottomEdgeIndicatorView.delegate = self
        leftEdgeIndicatorView.delegate = self
        
        topLeftCornerIndicatorView.delegate = self
        topRightCornerIndicatorView.delegate = self
        bottomRightCornerIndicatorView.delegate = self
        bottomLeftCornerIndicatorView.delegate = self
        
        topEdgeIndicatorView.frame.size = edgeIndicatorSize
        rightEdgeIndicatorView.frame.size = edgeIndicatorSize
        bottomEdgeIndicatorView.frame.size = edgeIndicatorSize
        leftEdgeIndicatorView.frame.size = edgeIndicatorSize

        topLeftCornerIndicatorView.frame.size = cornerIndicatorSize
        topRightCornerIndicatorView.frame.size = cornerIndicatorSize
        bottomRightCornerIndicatorView.frame.size = cornerIndicatorSize
        bottomLeftCornerIndicatorView.frame.size = cornerIndicatorSize
        
        self.addSubview(topEdgeIndicatorView)
        self.addSubview(rightEdgeIndicatorView)
        self.addSubview(bottomEdgeIndicatorView)
        self.addSubview(leftEdgeIndicatorView)

        self.insertSubview(topLeftCornerIndicatorView, at: 0)
        self.insertSubview(topRightCornerIndicatorView, at: 0)
        self.insertSubview(bottomRightCornerIndicatorView, at: 0)
        self.insertSubview(bottomLeftCornerIndicatorView, at: 0)

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
        super.layoutSubviews()
        updateIndicatorViewLayout()
    }
}

extension CroppingLayerView: EdgeIndicatorViewDelegate {
    func edgeIndicatorView(_ edgeIndicatorView: EdgeIndicatorView, didPanIndicatorWithTranslation translation: CGPoint) {
        var newFrame = self.frame
        guard let superviewFrame = self.superview?.bounds else { return }
        let maxWidthFromLeft = newFrame.origin.x + newFrame.width
        let maxWidthFromRight = superviewFrame.width - newFrame.origin.x
        let maxHeightFromTop = newFrame.origin.y + newFrame.height
        let maxHeightFromBottom = superviewFrame.height - newFrame.origin.y
        
        if edgeIndicatorView == leftEdgeIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x + translation.x, y: newFrame.origin.y, width: min(newFrame.width - translation.x, maxWidthFromLeft), height: newFrame.height)
        }
        if edgeIndicatorView == topEdgeIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y + translation.y, width: newFrame.width, height: min(newFrame.height - translation.y, maxHeightFromTop))
        }
        if edgeIndicatorView == rightEdgeIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y, width: min(newFrame.width + translation.x, maxWidthFromRight), height: newFrame.height)
        }
        if edgeIndicatorView == bottomEdgeIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y, width: newFrame.width, height: min(newFrame.height + translation.y, maxHeightFromBottom))
        }
        
        newFrame = limitedCroppingLayerRect(frame: newFrame)
        self.frame = newFrame
        self.updateIndicatorViewLayout()
        self.delegate?.croppingLayerViewChanged(self)
    }
}

extension CroppingLayerView: CornerIndicatorViewDelegate {
    func cornerIndicatorView(_ cornerIndicatorView: CornerIndicatorView, didPanIndicatorWithTranslation translation: CGPoint) {
        var newFrame = self.frame
        guard let superviewFrame = self.superview?.bounds else { return }
        let maxWidthFromLeft = newFrame.origin.x + newFrame.width
        let maxWidthFromRight = superviewFrame.width - newFrame.origin.x
        let maxHeightFromTop = newFrame.origin.y + newFrame.height
        let maxHeightFromBottom = superviewFrame.height - newFrame.origin.y
        
        if cornerIndicatorView == topLeftCornerIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x + translation.x, y: newFrame.origin.y + translation.y, width: min(newFrame.width - translation.x, maxWidthFromLeft), height: min(newFrame.height - translation.y, maxHeightFromTop))
        }
        if cornerIndicatorView == topRightCornerIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y + translation.y, width: min(newFrame.width + translation.x, maxWidthFromRight), height: min(newFrame.height - translation.y, maxHeightFromTop))
        }
        if cornerIndicatorView == bottomRightCornerIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y, width: min(newFrame.width + translation.x, maxWidthFromRight), height: min(newFrame.height + translation.y, maxHeightFromBottom))
        }
        if cornerIndicatorView == bottomLeftCornerIndicatorView {
            newFrame = CGRect(x: newFrame.origin.x + translation.x, y: newFrame.origin.y, width: min(newFrame.width - translation.x, maxWidthFromLeft), height: min(newFrame.height + translation.y, maxHeightFromBottom))
        }
        
        newFrame = limitedCroppingLayerRect(frame: newFrame)
        self.frame = newFrame
        self.updateIndicatorViewLayout()
        self.delegate?.croppingLayerViewChanged(self)
    }
}

protocol CroppingLayerViewDelegate: AnyObject {
    func croppingLayerViewChanged(_ croppingLayerView: CroppingLayerView)
}
