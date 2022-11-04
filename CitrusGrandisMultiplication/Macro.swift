//
//  Macro.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import Foundation
import UIKit
import XYZKit_master

let APAppdelegate = UIApplication.shared.delegate as? AppDelegate

//页面布局相关的
//通过安全距离判断是否是齐刘海
var isIphoneX : Bool {
    let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    if bottom > 0 {
        return true
    } else {
        return false
    }
}


let StatusBarHeigt = isIphoneX ? 44.0 : 20.0         //状态栏高度
let NavBarHeight = StatusBarHeigt + 44.0          //导航栏高度
let TabbarHeight = isIphoneX ? 34 + 49 : 49      //Tabbar的高度

let BottomSafeMargin = isIphoneX ? 34.0 : 0       //底部的安全距离
let SCREEN_Height = UIScreen.main.bounds.size.height //屏幕高度
let SCREEN_Width = UIScreen.main.bounds.size.width   //屏幕宽度


//Color
let MainTitleColor = UIColor(rgbString: "0x48627C")     //主标题颜色
let MainSubTitleColor = UIColor(rgbString: "0x939EA9")  //副标题颜色
let MainDividerColor = UIColor(rgbString: "0xF9F9F9")   //分割线的颜色

// MARK: toast
func toast(_ msg: String) {
    toast(msg, inView: nil)
}

// 相同toast不允许弹出
func toast(_ msg: String, detailMsg: String? = nil, inView: UIView?) {
    let prevent: (UIView?, String?, String?) -> Bool = {
        (view: UIView?, msg: String?, detailMsg: String?) -> Bool in
            guard view != nil || UIApplication.shared.delegate?.window != nil else {
                return false
            }
            let aboveView: UIView! = view ?? UIApplication.shared.delegate!.window!
            guard let hud = MBProgressHUD.forView(aboveView) else {
                return false
            }
            return hud.detailsLabel.text == detailMsg && hud.label.text == msg
    }
    guard !prevent(inView, msg, detailMsg) else {
        return
    }
    
    MBProgressHUD.xm_showTipMessage(msg, detaileMsg: detailMsg, time: 1.8, inview: inView) { hud in
        hud.margin = 13
        hud.label.font = 15.font
        hud.label.numberOfLines = 0
    }
}

func loading(_ inView: UIView? = nil) {
    
}

func loadingCancel(_ inView: UIView? = nil) {
    MBProgressHUD.xm_hideAllHUD(inView)
}

let mainColor = 0xacbc56.color
let grayColor = 0x474747.color
