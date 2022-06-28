//
//  ContainerView.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 28/06/2022.
//

import Foundation
import UIKit

class ContainerView: UIView{
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        for subview in subviews {
            let subviewPoint = subview.convert(point, from: self)
            if subview.point(inside: subviewPoint, with: event) { return true }
        }
        return true
    }
}

