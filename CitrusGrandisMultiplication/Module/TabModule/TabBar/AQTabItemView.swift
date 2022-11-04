//
//  AQTabItemView.swift
//  AquaticPlant
//
//  Created by songxin on 2022/7/7.
//

import Foundation
import SnapKit

protocol AQTabItemViewDelegate: AnyObject {
    func didSelectItem(_ item: AQTabItemModel);
    func didReSelectItem(_ item: AQTabItemModel);  //已选中，再次单击
}

class AQTabItemView: UIView {
    var item: AQTabItemModel
    weak var delegate: AQTabItemViewDelegate?
    var isSelected = false
    
    init(item: AQTabItemModel) {
        self.item = item
        super.init(frame: CGRect.zero)
        self.addTapGesture { [weak self] in
            //选中 - 动画
            if self?.isSelected == false {
                self?.delegate?.didSelectItem(item)
            } else {
                self?.delegate?.didReSelectItem(item)
            }
        }
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        _ = [contentImg, titleLabel]
        contentImg.image = item.normalImg
        titleLabel.text = item.title
    }
    
    private lazy var contentImg: UIImageView = {
        let img = UIImageView()
        self.addSubview(img)
        img.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let la = UILabel()
        la.font = 12.font
        self.addSubview(la)
        la.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentImg.snp.bottom).offset(2)
        }
        
        return la
    }()
    
    //选中的图片变化
    func select() {
        contentImg.image = item.selectedImg
        titleLabel.textColor = mainColor
        isSelected = true
        bounsAnimation()

    }
    
    //非选中的图片变化
    func deSelect() {
        contentImg.image = item.normalImg
        titleLabel.textColor = grayColor
        isSelected = false
        
        if item.type == .main {
            contentImg.isHidden = false
        }
    }
    
    private func bounsAnimation() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.transform = .identity
            } completion: { _ in
                
            }
        }
    }

}
