//
//  Tab3Cell.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/7.
//

import UIKit

class Tab3Cell: UITableViewCell {

    var drinkBarModel: DrinkBarModel? {
        didSet {
            title.text = drinkBarModel?.title
            if drinkBarModel?.img?.hasPrefix("file://") == true {
                imagev.image = UIImage(contentsOfFile: CacheUtil.sandboxPath?.appending(drinkBarModel?.img?.replacingOccurrences(of: "file://", with: "") ?? "") ?? "")!
            }else{
                imagev.image = UIImage(named: drinkBarModel?.img ?? "")
            }
            subtitle.text = drinkBarModel?.des
            dateBtn.setTitle(drinkBarModel?.date, for: .normal)
        }
    }
    
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
