//
//  AQBaseNavigationController.swift
//  AquaticPlant
//
//  Created by songxin on 2022/7/8.
//

import Foundation

class AQBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.setNavigationBarHidden(true, animated: false)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
