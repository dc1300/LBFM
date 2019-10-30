//
//  LBFMPlayDetailLikeController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/9/18.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import LTScrollView
import SwiftyJSON
import HandyJSON

class LBFMPlayDetailLikeController: UIViewController,LTTableViewProtocal {
    private  var albumResults:[LBFMClassifyVerticalModel]?
    private let LBFMPlayDetailLikeCellID = "LBFMPlayDetailLikeCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect.init(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMScreenHeight), self as UITableViewDelegate, self as UITableViewDataSource, nil)
        tableView.register(LBFMPlayDetailLikeCell.self, forCellReuseIdentifier: LBFMPlayDetailLikeCellID)
        tableView.uHead = URefreshHeader{
            [weak self] in self?.setupLoadData()
        }
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.tableView.uHead.beginRefreshing()
    }
    
    func setupLoadData() {
        LBFMPlayDetailProvider.request(LBFMPlayDetailAPI.playDetailLikeList(albumId: 12825974)){ result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.albumResults = mappedObject as? [LBFMClassifyVerticalModel]
                    self.tableView.uHead.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
}


extension LBFMPlayDetailLikeController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :LBFMPlayDetailLikeCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayDetailLikeCellID, for: indexPath) as! LBFMPlayDetailLikeCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.classifyVerticalModel = self.albumResults?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.albumResults?[indexPath.row].albumId ?? 0
        let vc = LBFMPlayDetailController(albumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
