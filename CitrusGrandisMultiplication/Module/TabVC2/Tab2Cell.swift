//
//  Tab2Cell.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/7.
//

import Foundation

class Tab2Cell: UITableViewCell {
    var makeModel: MakeModel? {
        didSet {
            title1.text = makeModel?.title
            subTitle.text = makeModel?.step
            content.text = makeModel?.tips
            startView.resetStar(makeModel?.stars ?? 0)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        _ = [contentViewbg, title1, subTitle, content, startView]
    }
    
    private lazy var contentViewbg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tab2输入框"))
        img.isUserInteractionEnabled = true
        contentView.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.height.equalTo(280)
        }
        
        return img
    }()
    
    private lazy var title1: UILabel = {
        let la = UILabel()
        la.textColor = .black
        la.font = 18.font
        contentViewbg.addSubview(la)
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
        contentViewbg.addSubview(la)
        la.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.top.equalTo(title1.snp.bottom).offset(3)
        }
        
        return la
    }()
    
    private lazy var content: UILabel = {
        let la = UILabel()
        la.textColor = 0x3a3a33.color
        la.font = 12.font
        la.numberOfLines = 0
        contentViewbg.addSubview(la)
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
        contentViewbg.addSubview(la)
        la.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(15)
            make.left.equalTo(subTitle)
        }
        
        return la
    }()
    
    private lazy var startView: StarView = {
        let v = StarView(frame: CGRect(x: 30, y: 300, width: 150, height: 44), index: 3, isCanEdit: false)
        
        contentViewbg.addSubview(v)
        v.snp.makeConstraints { make in
            make.left.equalTo(starPreLa.snp.right).offset(10)
            make.centerY.equalTo(starPreLa)
            make.size.equalTo(CGSize(width: 150, height: 44))
        }
        
        return v
    }()
}
