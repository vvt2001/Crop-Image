//
//  EdgeIndicatorView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import Foundation
import UIKit

class EdgeIndicatorView: UIView{
    
    var delegate: EdgeIndicatorViewDelegate?
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        delegate?.edgeIndicatorView(self, didPanIndicatorWithRecognizer: recognizer)
    }
    
    private func createView(){
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
        self.layer.cornerRadius = self.bounds.width/2
    }
}

protocol EdgeIndicatorViewDelegate{
    func edgeIndicatorView(_ edgeIndicatorView: EdgeIndicatorView, didPanIndicatorWithRecognizer recognizer: UIPanGestureRecognizer)
}
