//
//  TabViewController2.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation

class TabViewController2: AQBaseViewController {
    var dataSource: [MakeModel] = [MakeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bgImg
        
        navBarType = .light
        titleStr = "Do Yourself"

        let model = MakeModel(title: "Xiancao milk drink", step: "Use a small amount of water to mix the Guiling paste powder into a paste and put the remaining water into the pot Bring the water to a boil. After the liquid solidifies, the Guiling paste forms the pure milk poured into the cold storage.", tips: "People with cold stomach and weak spleen and stomach should not eat more.", stars: 4)
        
        if CacheUtil.share.markDrinkModel() == nil {
            dataSource.append(model)
        }else{
            dataSource = CacheUtil.share.markDrinkModel()!
        }
        
        _ = [topImg, makeBtn, tableView]
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
                
                if CacheUtil.share.markDrinkModel() == nil {
                    self.dataSource.removeAll()
                }
                self.dataSource.append(model)
                CacheUtil.share.setMarkDrinkModel(self.dataSource)
                self.tableView.reloadData()
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
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(Tab2Cell.classForCoder(), forCellReuseIdentifier: "Tab2Cell")
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topImg.snp.bottom)
        }
        
        return table
    }()
}

extension TabViewController2: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tab2Cell", for: indexPath) as? Tab2Cell
        cell?.makeModel = dataSource[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
