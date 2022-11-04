//
//  TabViewController1.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController1: AQBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bgImg
        
        navBarType = .light
        rightBtnImage = "tab1添加背景白色添加"
        titleStr = "Unlimited Drinking"
        
        
    }
    
    private func setupUI() {
        _ = [bgImg]
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab1-1"))
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return img
    }()
}
