//
//  DrinkDetailViewController.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/5.
//

import Foundation

class DrinkDetailViewController: AQBaseViewController {
    var drinkModel: DrinkModel? {
        didSet {
            if drinkModel?.image?.hasPrefix("file://") == true {
                if #available(iOS 16.0, *) {
                    proImg.image = UIImage(contentsOfFile: drinkModel?.image?.replacing("file://", with: "") ?? "")
                } else {
                    // Fallback on earlier versions
                }
            }else{
                proImg.image = UIImage(named: drinkModel?.image ?? "")
            }
            
            title1.text = drinkModel?.title
            subTitle.text = drinkModel?.subTitle
            content.text = drinkModel?.content
            priceLa.text = String(format: "%@$/cup", drinkModel?.price ?? "22")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = [bgImg]
        _ = NavBarHeight
        navBarType = .light
        showLeftBtn()
        titleStr = "Drink Details"
        
        _ = [backImg, proImg, title1, subTitle, content, priceLa]
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
    
    private lazy var backImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab1详情色块"))
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 350, height: 321))
            make.top.equalTo(230)
            make.centerX.equalToSuperview()
        }
        
        return img
    }()
    
    private lazy var proImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 180))
        }
        
        return img
    }()
    
    private lazy var title1: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 20.font
        backImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
        }
        
        return la
    }()
    
    private lazy var subTitle: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 14.font
        la.numberOfLines = 0
        backImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.top.equalTo(title1.snp.bottom).offset(20)
        }
        
        return la
    }()
    
    private lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = mainColor
        backImg.addSubview(v)
        v.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.centerY.equalToSuperview().offset(-10)
            make.height.equalTo(4)
        }
        
        return v
    }()
    
    private lazy var content: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 14.font
        la.numberOfLines = 0
        backImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        return la
    }()
    
    private lazy var priceLa: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 19.font
        backImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.bottom.equalTo(-30)
            make.centerX.equalToSuperview()
        }
        
        return la
    }()
}
