//
//  AQTabbarViewController.swift
//  AquaticPlant
//
//  Created by songxin on 2022/7/7.
//

import Foundation

class AQTabbarViewController: UITabBarController {
    let tabbar = AQTabbar() //自定义的tab
    private (set) var selectedItemType: AQTabItemType? //当前选中的tabType
    
    var types: [AQTabItemType] = [] //按顺序存放tab的type
    
    let vc1 = TabViewController1()
    let vc2 = TabViewController2()
    let vc3 = TabViewController3()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViewController()
    }
    
    /**
     配置系统的tabbar
     */
    func config() {
        //自定义Tabbar
        tabbar.aqTabDelegate = self
        self.setValue(tabbar, forKey: "tabBar")
    }
    
    /**
     配置viewcontrooler
     */
    func setupViewController() {
        var vcs: [UIViewController] = []
        var items: [AQTabItemModel] = []
        
        let recordModel = AQTabItemModel(type: .record, normalImg: UIImage(named: "2无限畅饮")!, selectedImg: UIImage(named: "1无限畅饮")!,title: "Unlimited Drinking")
        vcs.append(vc1)
        items.append(recordModel)
        types.append(.record)
        
        let gameModel = AQTabItemModel(type: .main, normalImg: UIImage(named: "4自己动手")!, selectedImg: UIImage(named: "3自己动手")!,title: "Do Yourself")
        vcs.append(AQBaseNavigationController(rootViewController: vc2))
        items.append(gameModel)
        types.append(.main)
        
        let mainModel = AQTabItemModel(type: .mine, normalImg: UIImage(named: "6饮品吧")!, selectedImg: UIImage(named: "5饮品吧")!,title: "Drink Bar")
        vcs.append(AQBaseNavigationController(rootViewController: vc3))
        items.append(mainModel)
        types.append(.mine)
        
        viewControllers = vcs
        
        tabbar.tabItems = items
        tabbar.reloadItems()
        
        tabbar.selectItem(.record)
    }
    
}

extension AQTabbarViewController: AQTabbarDelegate {
    func didSelectItem(_ item: AQTabItemModel) {
        selectedItemType = item.type
        
        self.selectedIndex = types.firstIndex(of: item.type) ?? 1
    }
    
    func didReSelectItem(_ item: AQTabItemModel) {
        
    }
    
}
