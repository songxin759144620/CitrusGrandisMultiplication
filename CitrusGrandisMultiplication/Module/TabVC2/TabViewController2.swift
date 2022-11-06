//
//  TabViewController2.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController2: AQBaseViewController {
    
    var makeModel: MakeModel? {
        didSet {
            title1.text = makeModel?.title
            subTitle.text = makeModel?.step
            content.text = makeModel?.tips
            startView.resetStar(makeModel?.stars ?? 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bgImg
        
        navBarType = .light
        titleStr = "Do Yourself"
        
        _ = [topImg, makeBtn, contentView, title1, subTitle, content, startView]
        
        makeModel = MakeModel(title: "Xiancao milk drink", step: "Use a small amount of water to mix the Guiling paste powder into a paste and put the remaining water into the pot Bring the water to a boil. After the liquid solidifies, the Guiling paste forms the pure milk poured into the cold storage.", tips: "People with cold stomach and weak spleen and stomach should not eat more.", stars: 4)
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab2-1"))
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return img
    }()
    
    private lazy var topImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab2-2"))
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(NavBarHeight)
            make.height.equalTo(225)
        }
        
        return img
    }()
    
    private lazy var makeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Making exquisite drinks", for: .normal)
        btn.setImage(UIImage(named: "tab2黑箭头"), for: .normal)
        btn.backgroundColor = 0xadb951.color.withAlphaComponent(0.8)
        btn.titleLabel?.font = 26.font
        btn.setTitleColor(.black, for: .normal)
        btn.addTapGesture { [weak self] in
            let vc = MakeDrinkVC()
            vc.hidesBottomBarWhenPushed = true
            vc.saveBlock = {[weak self] model in
                guard let self = self else { return }
                self.makeModel = model
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        topImg.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        view.layoutIfNeeded()
        btn.setImageTitleLayout(.imgRight, spacing: 5)
        
        return btn
    }()
    
    private lazy var contentView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab2输入框"))
        img.isUserInteractionEnabled = true
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(topImg.snp.bottom).offset(15)
            make.height.equalTo(275)
        }
        
        return img
    }()
    
    private lazy var title1: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 18.font
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(40)
        }
        
        return la
    }()
    
    private lazy var subTitle: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 12.font
        la.numberOfLines = 0
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(title1.snp.bottom).offset(3)
        }
        
        return la
    }()
    
    private lazy var content: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 12.font
        la.numberOfLines = 0
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(30)
            make.left.right.equalTo(subTitle)
        }
        
        return la
    }()
    
    private lazy var starPreLa: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 12.font
        la.text = "Evaluation:"
        contentView.addSubview(la)
        la.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(10)
            make.left.equalTo(subTitle)
        }
        
        return la
    }()
    
    private lazy var startView: StarView = {
        let v = StarView(frame: CGRect(x: 30, y: 300, width: 150, height: 44), index: 3, isCanEdit: false)
        
        contentView.addSubview(v)
        v.snp.makeConstraints { make in
            make.left.equalTo(starPreLa.snp.right).offset(10)
            make.centerY.equalTo(starPreLa)
            make.size.equalTo(CGSize(width: 150, height: 44))
        }
        
        return v
    }()
}
