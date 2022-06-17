//
//  CornerIndicatorView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import Foundation
import UIKit

class CornerIndicatorView: UIView{
    
    var delegate: CornerIndicatorViewDelegate?
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        delegate?.cornerIndicatorView(self, didPanIndicatorWithRecognizer: recognizer)
    }
    
    private func createView(){
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.bounds.width/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createView()
    }
}

protocol CornerIndicatorViewDelegate{
    func cornerIndicatorView(_ cornerIndicatorView: UIView, didPanIndicatorWithRecognizer recognizer: UIPanGestureRecognizer)
}
