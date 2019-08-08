//
//  LBFMHomeClassifyModel.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import Foundation
import HandyJSON

struct  LBFMHomeClassifyModel: HandyJSON {
    var list: [LBFMClassifyModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}

struct LBFMClassifyModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList:[LBFMItemList]?
}

struct LBFMItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: LBFMItemDetail?
}

struct LBFMItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}
