//
//  AQTabbar.swift
//  AquaticPlant
//
//  Created by songxin on 2022/7/7.
//

import Foundation
import XYZKit_master

protocol AQTabbarDelegate: AnyObject {
    /// 单击事件
    func didSelectItem(_ item: AQTabItemModel);
    
    /// 单击事件 - 已选中 - 再次点击
    func didReSelectItem(_ item: AQTabItemModel);
}

class AQTabbar: UITabBar {
    var aqTabDelegate: AQTabbarDelegate?
    var tabItems: [AQTabItemModel]?
    var tabItemViews: [AQTabItemView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = false
        if #available(iOS 13.0, *) {
            let appearance = self.standardAppearance.copy()
            appearance.backgroundImage = UIImage.image(with: .white)
            appearance.backgroundColor = .white
            appearance.shadowImage = UIImage.image(with: .clear)
            appearance.shadowColor = .clear
            self.standardAppearance = appearance
        }
        //去除顶部很丑的border
        self.shadowImage = UIImage.image(with: .clear)
        self.tintColor = UIColor.clear
        self.barTintColor = UIColor.clear
        self.backgroundImage = UIImage.image(with: .white)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func reloadItems() {
        createView()
    }
    
    private func createView() {
        if let newItems = self.tabItems {
            let itemwidth = floor(SCREEN_Width / CGFloat(newItems.count))
            for i in 0..<newItems.count {
                let tabItemView = AQTabItemView(item: newItems[i])
                tabItemView.delegate = self
                self.addSubview(tabItemView)
                tabItemView.frame = CGRect(x: CGFloat(i) * itemwidth, y: 0, width: itemwidth, height: 49)
                tabItemViews.append(tabItemView)
            }
        }
    }
    
    //设置选中tab
    func selectItem(_ type:AQTabItemType) {
        for i in 0..<tabItems!.count {
            let item = tabItems![i]
            if item.type == type {
                self.didSelectItem(item)
                return
            }
        }
    }
    
    func itemView(_ type: AQTabItemType) -> AQTabItemView? {
        for i in 0..<tabItems!.count {
            let item = tabItems![i]
            if item.type == type {
                return tabItemViews[i]
            }
        }
        return nil
    }
}

extension AQTabbar: AQTabItemViewDelegate {
    func didSelectItem(_ item: AQTabItemModel) {
        //控制选中动画、反选
        for i in 0..<tabItemViews.count {
            let aItem = tabItemViews[i]
            if aItem.item.type == item.type {
                aItem.select()
            } else {
                aItem.deSelect()
            }
        }
        self.aqTabDelegate?.didSelectItem(item)
    }
    
    func didReSelectItem(_ item: AQTabItemModel) {
        self.aqTabDelegate?.didReSelectItem(item)
    }
}
