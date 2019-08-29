//
//  LBFMHomeController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/7.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import DNSPageView
class LBFMHomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageStyle()
    }
    

    func setupPageStyle(){
        let style = DNSPageStyle.init()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = LBFMButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let viewControllers:[UIViewController] = [
            LBFMHomeRecommendController.init(),
            LBFMHomeClassifyController.init(),
            LBFMHomeVIPController.init(),
            LBFMHomeLiveController.init(),
            LBFMHomeBroadcastController.init()
        ]
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = DNSPageView.init(frame: CGRect.init(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight-44-LBFMNavBarHeight), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
    }

}
