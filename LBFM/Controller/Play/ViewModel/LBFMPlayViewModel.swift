//
//  LBFMPlayViewModel.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/9.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

import SwiftyJSON
import HandyJSON

class LBFMPlayViewModel: NSObject {
    // 外部传值请求接口如此那
    var albumId :Int = 0
    var trackUid:Int = 0
    var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0,uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    var playTrackInfo:LBFMPlayTrackInfo?
    var playCommentInfo:[LBFMPlayCommentInfo]?
    var userInfo:LBFMPlayUserInfo?
    var communityInfo:LBFMPlayCommunityInfo?
    // - 数据源更新
    typealias LBFMAddDataBlock = () ->Void
    var updataBlock:LBFMAddDataBlock?
}

extension LBFMPlayViewModel {
    func refreshDataSource() {
        LBFMPlayProvider.request(LBFMPlayAPI.fmPlayData(albumId: self.albumId, trackUid: self.trackUid, uid: self.uid)) { (result) in
            if case let .success(response) = result{
                let data = try?response.mapJSON()
                let json = JSON(data!)
                if let playTrackInfo = JSONDeserializer<LBFMPlayTrackInfo>.deserializeFrom(json: json["trachInfo"].description){
                    self.playTrackInfo = playTrackInfo
                }
                
                if let commentInfo = JSONDeserializer<LBFMPlayCommentInfoList>.deserializeFrom(json: json["noCacheInfo"]["commentInfo"].description){
                    self.playCommentInfo = commentInfo.list
                }
                
                if let userInfoData = JSONDeserializer<LBFMPlayUserInfo>.deserializeFrom(json: json["userInfo"].description) {
                    self.userInfo = userInfoData
                }
                
                if let communityInfoData = JSONDeserializer<LBFMPlayCommunityInfo>.deserializeFrom(json: json["noCacheInfo"]["communityInfo"].description){
                    self.communityInfo = communityInfoData
                }
                self.updataBlock?()
            }
        }
    }
}


extension LBFMPlayViewModel {//: UICollectionViewDelegate,UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3{
            return self.playCommentInfo?.count ?? 0
        }
        return 1
    }
    
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize.init(width:LBFMScreenWidth,height:LBFMScreenHeight * 0.7)
        }else if indexPath.section == 3{
            let textHeight = height(for: self.playCommentInfo?[indexPath.row])+100
            return CGSize.init(width:LBFMScreenWidth,height:textHeight)
        }else{
            return CGSize.init(width:LBFMScreenWidth,height:140)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return CGSize.init(width: LBFMScreenHeight, height:40)
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: LBFMScreenWidth, height: 10.0)
    }
    
    // 计算文本高度
    func height(for commentModel: LBFMPlayCommentInfo?) -> CGFloat {
        var height: CGFloat = 10
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = model.content
        height += label.sizeThatFits(CGSize(width: LBFMScreenWidth - 80, height: CGFloat.infinity)).height
        return height
    }

    
}