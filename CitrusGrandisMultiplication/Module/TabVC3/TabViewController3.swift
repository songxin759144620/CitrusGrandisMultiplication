//
//  TabViewController3.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController3: AQBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bgImg
        
        navBarType = .light
        titleStr = "Drink Bar"
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab3-1"))
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return img
    }()
}
