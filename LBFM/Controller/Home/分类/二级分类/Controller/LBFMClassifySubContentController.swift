//
//  LBFMClassifySubContentController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class LBFMClassifySubContentController: UIViewController {
    // - 上页面传过来请求接口必须的参数
    private var keywordId: Int = 0
    private var categoryId: Int = 0
    convenience init(keywordId: Int = 0, categoryId:Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    
    // - 定义接收的数据模型
    private var classifyVerticallist:[LBFMClassifyVerticalModel]?
    private let LBFMClassifySubVerticalCellID = "LBFMClassifySubVerticalCellID"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize.init(width: LBFMScreenWidth - 15, height: 120)
        let collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self as! UICollectionViewDelegate
        collection.dataSource = self as! UICollectionViewDataSource
        collection.backgroundColor = UIColor.white
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: LBFMClassifySubVerticalCellID)
        collection.uHead = URefreshHeader {
            [weak self] in self?.setupLoadData()
        }
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.top.bottom.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData(){
        LBFMClassifySubMenuProvider.request(.classifyOtherContentList(keywordId: self.keywordId, categoryId: self.categoryId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMClassifyVerticalModel>.deserializeModelArrayFrom(json: json["list"].description){
                    self.classifyVerticallist = mappedObject as? [LBFMClassifyVerticalModel]
                    self.collectionView.uHead.endRefreshing()
                    self.collectionView.reloadData()
                }
            }
        }
    }

    
}

extension LBFMClassifySubContentController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyVerticallist?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMClassifySubVerticalCellID, for: indexPath) as! LBFMClassifySubVerticalCell
        cell.classifyVerticalModel = self.classifyVerticallist?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = self.classifyVerticallist?[indexPath.row].albumId ?? 0
//        let vc = LBFMPlayController(albumId:albumId)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
