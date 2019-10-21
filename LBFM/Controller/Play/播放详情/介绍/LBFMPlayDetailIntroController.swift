//
//  LBFMPlayDetailIntroController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/9/18.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import LTScrollView

class LBFMPlayDetailIntroController: UIViewController,LTTableViewProtocal {
    private var playDetailAlbum:LBFMPlayDetailAlbumModel?
    private var playDetailUser:LBFMPlayDetailUserModel?
    
    private lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect.init(x: 0, y: 0, width: LBFMScreenWidth, height: LBFMScreenHeight), self as! UITableViewDelegate, self as! UITableViewDataSource, nil)
        tableView.register(LBFMPlayContentIntroCell.self, forCellReuseIdentifier: "LBFMPlayContentIntroCellID")
        tableView.register(LBFMPlayAnchorIntroCell.self, forCellReuseIdentifier: "LBFMPlayAnchorIntroCellID")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    //内容简介model
    var playDetailAlbumModel: LBFMPlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {
                return
            }
            self.playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.none)
            }
        }
    }
    // 主播简介model
    var playDetailUserModel:LBFMPlayDetailUserModel? {
        didSet{
            guard let model = playDetailUserModel else {return}
            self.playDetailUser = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableView.RowAnimation.none)
            }        }
        
    }
}

extension LBFMPlayDetailIntroController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
}
