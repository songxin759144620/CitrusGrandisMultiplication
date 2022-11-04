//
//  AQTabItemModel.swift
//  AquaticPlant
//
//  Created by songxin on 2022/7/7.
//

import Foundation
import UIKit

enum AQTabItemType: Int {
    case record = 1
    case main = 2
    case mine = 3
}

struct AQTabItemModel {
    let type: AQTabItemType
    let normalImg: UIImage
    let selectedImg: UIImage
    let title: String
    
    init(type: AQTabItemType, normalImg: UIImage, selectedImg: UIImage, title: String) {
        self.type = type
        self.normalImg = normalImg
        self.selectedImg = selectedImg
        self.title = title
    }
}
