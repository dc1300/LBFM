//
//  LBFMHeader.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/1.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages


let LBFMScreenWidth = UIScreen.main.bounds.size.width
let LBFMScreenHeight = UIScreen.main.bounds.size.height

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = LBFMScreenHeight >= 812 ? true : false
// LBFMNavBarHeight
let LBFMNavBarHeight : CGFloat =  __kStatusBarHeight__ + 44
// LBFMTabBarHeight
let LBFMTabBarHeight : CGFloat = safeAreaInsetsBottom()
    //isIphoneX ? 49 + 34 : 49


let __kStatusBarHeight__ = UIApplication.shared.statusBarFrame.size.height
let __kNavigationBarHeight__ = __kStatusBarHeight__ + 44
let __kTabbarSafeBottomMargin__ = safeAreaInsetsBottom()

func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
func safeAreaInsetsBottom() -> CGFloat {
    if #available(iOS 11.0, *) {
        let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets
        return safeAreaInsets!.bottom
    }else{
        return 0
    }
}
