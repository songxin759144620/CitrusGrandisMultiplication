//
//  DrinkProductCell.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/5.
//

import Foundation

class DrinkProductCell: UITableViewCell {
    var drinkModel: DrinkModel? {
        didSet {
            if drinkModel?.image?.hasPrefix("file://") == true {
                proImg.image = UIImage(contentsOfFile: drinkModel?.image?.replacingOccurrences(of: "file://", with: "") ?? "")
            }else{
                proImg.image = UIImage(named: drinkModel?.image ?? "")
            }
            
            title.text = drinkModel?.title
            subTitle.text = drinkModel?.subTitle
            content.text = drinkModel?.content
            priceLa.text = String(format: "%@$/cup", drinkModel?.price ?? "22")
        }
    }
    
    var deleteBlock: (()->Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        _ = [bgImg, title, subTitle, line, content, priceLa, closeBtn, detailBtn,proImg]
    }
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab1色块"))
        img.isUserInteractionEnabled = true
        contentView.addSubview(img)
        img.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
        
        return img
    }()
    
    private lazy var proImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        bgImg.addSubview(img)
        img.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.left.equalTo(30)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        return img
    }()
    
    private lazy var title: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 17.font
        bgImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(32)
        }
        
        return la
    }()
    
    private lazy var subTitle: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 10.font
        la.numberOfLines = 0
        bgImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(140)
            make.width.equalTo(150)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        return la
    }()
    
    private lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = mainColor
        bgImg.addSubview(v)
        v.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 4))
            make.left.equalTo(95)
            make.top.equalTo(110)
        }
        
        return v
    }()
    
    private lazy var content: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 10.font
        la.numberOfLines = 0
        bgImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.left.equalTo(140)
            make.width.equalTo(150)
        }
        
        return la
    }()
    
    private lazy var priceLa: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 13.font
        bgImg.addSubview(la)
        la.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.top.equalTo(128)
        }
        
        return la
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "tab1白色差号 1"), for: .normal)
        btn.addTapGesture { [weak self] in
            self?.deleteBlock?()
        }
        bgImg.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.top.equalToSuperview()
            make.left.equalTo(SCREEN_Width * 258 / 414.0)
        }
        
        return btn
    }()
    
    private lazy var detailBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "tab1向下详情"), for: .normal)
        btn.setTitle("Details", for: .normal)
        btn.titleLabel?.font = 10.font
        btn.setTitleColor(mainColor, for: .normal)
        btn.addTapGesture {
            
        }
        bgImg.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 20))
            make.centerX.equalToSuperview().offset(8)
            make.bottom.equalTo(-8)
        }
        layoutIfNeeded()
        btn.setImageTitleLayout(.imgRight, spacing: -2)
        return btn
    }()
}
