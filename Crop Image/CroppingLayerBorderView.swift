//
//  CroppingLayerBorderView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 24/06/2022.
//

import Foundation
import UIKit

class CroppingLayerBorderView: UIView{
    private func setupView() {
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.link.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
