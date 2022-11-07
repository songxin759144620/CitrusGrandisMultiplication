//
//  TabViewController3.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/6.
//

import UIKit

class TabViewController3: AQBaseViewController {

    @IBOutlet weak var arrbg: UIImageView!
    @IBOutlet weak var arr: UIImageView!
    @IBOutlet weak var pushBtn: UIImageView!
    
    
    
    var dataSource: [DrinkBarModel] = [DrinkBarModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = .light
        titleStr = "Drink Bar"
        // Do any additional setup after loading the view.
        arr.snp.makeConstraints { make in
            make.centerY.equalTo(arrbg)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 40, height: 28))
        }
        let model = DrinkBarModel(title: "The past of orange",img: "tab3-2",des: "This is the story I don't like to recall. It makes me sad. My favorite orange The juice maker died, and I can't drink any more.",date: "2022-10-30")
        
        if CacheUtil.share.drinkBarData() == nil {
            dataSource.append(model)
        }else{
            dataSource = CacheUtil.share.drinkBarData()!
        }
        
        pushBtn.isUserInteractionEnabled = true
        pushBtn.addTapGesture { [weak self] in
            let vc = OtherStoryViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.addStoryBlock = { [weak self] model in
                guard let self = self else { return }
                
                if CacheUtil.share.drinkBarData() == nil {
                    self.dataSource.removeAll()
                }
                self.dataSource.append(model)
                CacheUtil.share.setDrinkBarData(self.dataSource)
                self.tableView.reloadData()
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        _ = tableView
    }

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "Tab3Cell", bundle: nil), forCellReuseIdentifier: "Tab3Cell")
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(NavBarHeight + 60)
        }
        
        return table
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabViewController3: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tab3Cell", for: indexPath) as? Tab3Cell
        cell?.drinkBarModel = dataSource[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 405
    }
}
