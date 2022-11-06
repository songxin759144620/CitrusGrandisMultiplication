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
    @IBOutlet weak var titleLa: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var contentImg: UIImageView!
    @IBOutlet weak var pushBtn: UIImageView!
    
    var drinkBarModel: DrinkBarModel? {
        didSet {
            titleLa.text = drinkBarModel?.title
            if drinkBarModel?.img?.hasPrefix("file://") == true {
                contentImg.image = UIImage(contentsOfFile: drinkBarModel?.img?.replacingOccurrences(of: "file://", with: "") ?? "")!
            }else{
                contentImg.image = UIImage(named: drinkBarModel?.img ?? "")
            }
            des.text = drinkBarModel?.des
            dateBtn.setTitle(drinkBarModel?.date, for: .normal)
        }
    }
    
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
        drinkBarModel = DrinkBarModel(title: "The past of orange",img: "tab3-2",des: "This is the story I don't like to recall. It makes me sad. My favorite orange The juice maker died, and I can't drink any more.",date: "2022-10-30")
        des.numberOfLines = 0
        if CacheUtil.share.drinkBarData() == nil {
            CacheUtil.share.setDrinkBarData(drinkBarModel!)
        }else{
            drinkBarModel = CacheUtil.share.drinkBarData()
        }
        
        pushBtn.isUserInteractionEnabled = true
        pushBtn.addTapGesture { [weak self] in
            let vc = OtherStoryViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.addStoryBlock = { [weak self] model in
                self?.drinkBarModel = model
                CacheUtil.share.setDrinkBarData(model)
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
