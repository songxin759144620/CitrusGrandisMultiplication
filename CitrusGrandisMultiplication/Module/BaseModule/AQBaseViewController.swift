//
//  AQBaseViewController.swift
//  AquaticPlant
//
//  Created by songxin on 2022/6/28.
//

import Foundation

enum NavBarType {
    case light    //白色背景
    case clean    //透明背景
}

@objc class AQBaseViewController: UIViewController {
    var errorTapAction: (()->Void)?  //异常view的按钮事件（用于刷新，重新加载等）
    
    var navBarType: NavBarType = .light {
        didSet {
            configNavBar(type: navBarType)
        }
    }
    private let leftBtn = UIButton(type: .custom)
    private var rightBtn = UIButton(type: .custom)
    //导航栏右上角图片
    var rightBtnImage: String = "" {
        didSet {
            rightBtn.setImage(UIImage(named: rightBtnImage), for: .normal)
        }
    }
    //盗汗蓝右上角标题
    var rightBtnStr: String = "" {
        didSet {
            rightBtn.setTitle(rightBtnStr, for: .normal)
        }
    }
    
    private var titleLabel = UILabel()
    //导航栏标题
    var titleStr: String = "" {
        didSet {
            titleLabel.text = titleStr
        }
    }
    
    func showLeftBtn() {
        leftBtn.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        leftBtn.isHidden = true
        view.clipsToBounds = true
    }
    
    private func configNavBar(type: NavBarType) {
        let navBarView = UIView()
        
        titleLabel.font = 20.fontMedium
        titleLabel.textAlignment = .center
        
        if type == .light {
            navBarView.backgroundColor = mainColor
            leftBtn.setImage(UIImage(named: "返回"), for: .normal)
            titleLabel.textColor = .white
        }else{
            navBarView.backgroundColor = .clear
            leftBtn.setImage(UIImage(named: "leftBtn_clean"), for: .normal)
            titleLabel.textColor = .white
        }
        
        view.addSubview(navBarView)
        navBarView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(NavBarHeight)
        }
        
        leftBtn.addTapGesture {[weak self] in
            self?.leftBtnAction()
        }
        navBarView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(StatusBarHeigt)
            make.width.height.equalTo(44)
        }
        
        navBarView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(StatusBarHeigt)
            make.height.equalTo(44)
        })
        
        navBarView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints({ make in
            make.right.equalTo(-30)
            make.width.height.equalTo(44)
            make.top.equalTo(StatusBarHeigt)
        })
        rightBtn.addTapGesture {[weak self] in
            self?.rightBtnAction()
        }
    }
}

//override
extension AQBaseViewController {
    
    @objc func rightBtnAction() {
        
    }
    
    @objc func leftBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
