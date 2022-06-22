//
//  CornerIndicatorView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import Foundation
import UIKit

class CornerIndicatorView: UIView {
    
    var delegate: CornerIndicatorViewDelegate?
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        delegate?.cornerIndicatorView(self, didPanIndicatorWithTranslation: recognizer.translation(in: self))
        recognizer.setTranslation(.zero, in: self)
    }
    
    private func createView() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        self.backgroundColor = UIColor.link
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
    }
}

protocol CornerIndicatorViewDelegate {
    func cornerIndicatorView(_ cornerIndicatorView: CornerIndicatorView, didPanIndicatorWithTranslation translation: CGPoint)
}
