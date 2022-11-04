//
//  TabViewController2.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController2: AQBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bgImg
        
        navBarType = .light
        titleStr = "Do Yourself"
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab1添加背景"))
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return img
    }()
}
