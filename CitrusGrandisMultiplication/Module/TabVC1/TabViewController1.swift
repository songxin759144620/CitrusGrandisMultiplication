//
//  TabViewController1.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController1: AQBaseViewController {
    var dataSource: [DrinkModel] = [DrinkModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.append(DrinkModel(title: "Strawberry juice", subTitle: "Ingredients: strawberry, water,sugar, coconut Sweet, pigment", content: "Strawberry juice is standard in summer, which is very popular Love of light people.", image: "tab1-2", price: "15"))
        dataSource.append(DrinkModel(title: "Lime water", subTitle: "Ingredients: lemon, water, sugar, coriander, cream", content: "Lime juice is a kind of strange drink People dare not try easily.", image: "tab1-3", price: "22"))
        
        if CacheUtil.share.drinkList() == nil {
            CacheUtil.share.writeDrinkList(dataSource)
        }else{
            dataSource = CacheUtil.share.drinkList()!
        }
        
        _ = [bgImg, tableView]
        
        navBarType = .light
        rightBtnImage = "tab1添加背景白色添加"
        titleStr = "Unlimited Drinking"
    }
    override func rightBtnAction() {
        let vc = AddDrinkViewController()
        vc.addDrinkBlock = { [weak self] drinkModel in
            if drinkModel != nil {
                self?.dataSource.append(drinkModel!)
                CacheUtil.share.writeDrinkList(self?.dataSource ?? [DrinkModel]())
                self?.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
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
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(DrinkProductCell.classForCoder(), forCellReuseIdentifier: "DrinkProductCell")
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(NavBarHeight)
        }
        
        return table
    }()
}

extension TabViewController1: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkProductCell", for: indexPath) as? DrinkProductCell
        cell?.drinkModel = dataSource[indexPath.row]
        cell?.deleteBlock = { [weak self] in
            self?.dataSource.remove(at: indexPath.row)
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.tableView.endUpdates()
            CacheUtil.share.writeDrinkList(self?.dataSource ?? [DrinkModel]())
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrinkDetailViewController()
        vc.drinkModel = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        hidesBottomBarWhenPushed = true
    }
}
