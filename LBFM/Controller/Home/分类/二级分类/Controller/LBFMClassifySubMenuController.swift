//
//  LBFMClassifySubMenuController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView
class LBFMClassifySubMenuController: UIViewController {
    private var categoryId: Int = 0
    private var isVipPush : Bool = false
    convenience init(categoryId:Int = 0, isVipPush:Bool = false){
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    
    private var Keywords:[LBFMClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    private lazy var keywordIdArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderCategoryData()
    }

    func loadHeaderCategoryData() {
        //分类二级界面顶部分类接口
        LBFMClassifySubMenuProvider.request(LBFMClassifySubMenuAPI.headerCategoryList(categoryId: self.categoryId)) { (result) in
            if case let .success(respose) = result{
                let data = try? respose.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description){
                    self.Keywords = mappedObject as? [LBFMClassifySubMenuKeywords]
                    for keyword in self.Keywords!{
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush{
                        self.nameArray.insert("推荐", at: 0)
                    }
                    self.setupHeaderView()
                }
            }
        }
    }
    func setupHeaderView() {
        let style = DNSPageStyle.init()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = LBFMButtonColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = LBFMDownColor
        
        var viewControllers = [UIViewController]()
        for keyword in self.Keywords! {
            let controller = LBFMClassifySubContentController.init(keywordId: keyword.keywordId, categoryId: keyword.categoryId)
            viewControllers.append(controller)
        }
        
        if !self.isVipPush {
            let categoryId = self.Keywords?.last?.categoryId
            viewControllers.insert(LBFMClassifySubRecommendController(categoryId:categoryId!), at: 0)
        }
        
        for vc in viewControllers{
            self.addChild(vc)
        }
        
        let pageView = DNSPageView(frame: CGRect(x: 0, y: LBFMNavBarHeight, width: LBFMScreenWidth, height: LBFMScreenHeight - LBFMNavBarHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
}

