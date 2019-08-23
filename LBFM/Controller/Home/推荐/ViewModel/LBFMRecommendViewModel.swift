
//
//  LBFMRecommendViewModel.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/23.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMRecommendViewModel: NSObject {
    
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updateDataBlock:AddDataBlock?
}

extension LBFMRecommendViewModel{
    func refreshDataSource() {
        //首页推荐接口请求
        LBFMRecommendProvider.request(LBFMRecommendAPI.recommendList) { (result) in
            if case let .success(response) = result{
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON.init(data: data! as! Data)
                if let mappedObject = JSONDeserializer<LBFMHomeRecommendModel>.deserializeFrom(json: json.description)
                
            }
        }
    }
}
