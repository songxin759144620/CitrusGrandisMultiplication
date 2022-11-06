//
//  StarView.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/5.
//

import Foundation
import UIKit

//block回调
typealias LDStarEvaluationTapBlock = (_ starEvaluationView: StarView,_ index : Int) ->()

class StarView: UIView {
    
    //block回调

    var starEvaluationTapBlock: LDStarEvaluationTapBlock!
    
    //默认图片
    var defaultImage: UIImage?
    
    //高亮图片
    var lightImage: UIImage?
    var isTap: Bool = false
    
    /// 星级评定
    ///
    /// - Parameters:
    ///   - frame: 视图frame
    ///   - starIndex: 评定星级级别
    ///   - starWidth: 每个星星的宽度
    ///   - starSpace: 星星之间的间隔
    ///   - normalImage: 默认状态图片
    ///   - lightImage: 高亮状态图片
    ///   - isCanTap: 上方可以编辑
    init(frame: CGRect, index starIndex: Int, width starWidth: CGFloat = 20, space starSpace: CGFloat = 5, normalImage defaultImage: UIImage = UIImage(named: "tab2灰星")!,selectImage lightImage: UIImage = UIImage(named: "tab2红星")!, isCanEdit isCanTap: Bool) {
        super.init(frame: frame)
        self.defaultImage = defaultImage
        self.lightImage = lightImage
        self.isTap = isCanTap
        setupUI(index: starIndex, width: starWidth, space: starSpace, isTap: isCanTap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(index starIndex: Int, width starWidth: CGFloat, space starSpace: CGFloat, isTap isCanTap: Bool){
        for i in 0..<5 {
            let btn = UIButton()
            btn.frame = CGRect(x: CGFloat(i) * (starWidth + starSpace), y: 0, width: starWidth, height: self.frame.size.height)
            btn.tag = i + 1
            btn.addTarget(self, action: #selector(starTapBtn(_:)), for: .touchUpInside)
            btn.imageEdgeInsets = UIEdgeInsets(top: (self.frame.size.height - starWidth) * 0.5, left: 0, bottom: (self.frame.size.height - starWidth) * 0.5, right: 0)
            if i < starIndex {
                btn.setImage(self.lightImage, for: .normal)
            } else {
                btn.setImage(self.defaultImage, for: .normal)
            }
            btn.adjustsImageWhenHighlighted = false
            self.addSubview(btn)
            
            self.frame.size.width = (starWidth + starSpace) * 5
        }
    }
    
    func resetStar(_ index: Int) {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        setupUI(index: index, width: 20, space: 5, isTap: isTap)
    }
    
    @objc func starTapBtn(_ sender: UIButton) {
        if isTap == false { return }
        for i in 1...5  {
            let starBtn = self.viewWithTag(i) as! UIButton
            if i <= sender.tag {
                starBtn.setImage(self.lightImage, for: .normal)
            } else {
                starBtn.setImage(self.defaultImage, for: .normal)
            }
        }
        if starEvaluationTapBlock != nil {
            starEvaluationTapBlock(self, sender.tag)
        }
    }
}
