//
//  CacheUtil.swift
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/6.
//

import Foundation
import HandyJSON

class cat: HandyJSON {
    var a: Int?
    required init() {
        
    }
}

class CacheUtil {
    static let share = CacheUtil()
    static let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    
    var userDefault = UserDefaults.standard
    
    /**
        首页数据
     */
    let DrinkList = "DrinkList"
    
    func drinkList() -> [DrinkModel]?  {
        let listStr = userDefault.object(forKey: DrinkList) as? String
        let listModel = [DrinkModel].deserialize(from: listStr) as? [DrinkModel]
        return listModel
    }
    
    func writeDrinkList(_ list: [DrinkModel]) {
        userDefault.set(list.toJSON().toJSONString, forKey: DrinkList)
    }
    
    /**
     tab2的数据
     */
    let MakeDrink = "MakeDrink"
    
    func markDrinkModel() -> [MakeModel]?  {
        let listStr = userDefault.object(forKey: MakeDrink) as? String
        let listModel = [MakeModel].deserialize(from: listStr) as? [MakeModel]
        return listModel
    }
    
    func setMarkDrinkModel(_ model: [MakeModel]) {
        userDefault.set(model.toJSON().toJSONString, forKey: MakeDrink)
    }
    
    
    /**
     tab3的数据
     */
    let DrinkBarCache = "DrinkBarCache"
    
    func drinkBarData() -> [DrinkBarModel]?  {
        let listStr = userDefault.object(forKey: DrinkBarCache) as? String
        let listModel = [DrinkBarModel].deserialize(from: listStr) as? [DrinkBarModel]
        return listModel
    }
    
    func setDrinkBarData(_ model: [DrinkBarModel]) {
        userDefault.set(model.toJSON().toJSONString, forKey: DrinkBarCache)
    }
    
}
