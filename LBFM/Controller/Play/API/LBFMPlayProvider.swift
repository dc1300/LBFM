//
//  LBFMPlayProvider.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/9.
//  Copyright © 2019 戴晨. All rights reserved.
//

import Foundation

import Moya
import HandyJSON

let LBFMPlayProvider = MoyaProvider<LBFMPlayAPI>()

enum LBFMPlayAPI {
    case fmPlayData(albumId:Int, trackUid:Int, uid:Int)
}

extension LBFMPlayAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .fmPlayData( _, let trackUid, _):
            return "/mobile/track/v2/playpage/\(trackUid)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
        
    }
    
    var task: Task {
        var parmeters = [
            "device":"iPhone",
            "operator":3,
            "scale":3,
            "appid":0,
            "ac":"WIFI",
            "network":"WIFI",
            "version":"6.5.3",
            "uid":124057809,
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        switch self {
        case .fmPlayData(let albumId, _, let uid):
            parmeters["albumId"] = albumId
            parmeters["trackUid"] = uid
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
