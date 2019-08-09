//
//  LBFMPlayController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/7.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMPlayController: UIViewController {
    // 外部传值请求接口
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    
    convenience init(albumId:Int , trackUid:Int, uid:Int){
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    private let LBFMPlayHeaderViewID      = "LBFMPlayHeaderView"
    private let LBFMPlayFooterViewID      = "LBFMPlayFooterView"
    
    private let LBFMPlayCellID            = "LBFMPlayCell"
    private let LBFMPlayCommentCellID     = "LBFMPlayCommentCell"
    private let LBFMPlayAnchorCellID      = "LBFMPlayAnchorCell"
    private let LBFMPlayCircleCellID      = "LBFMPlayCircleCell"
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
        collection.register(LBFMPlayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMPlayHeaderViewID)
        collection.register(LBFMPlayFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMPlayFooterViewID)
        // - 注册不同分区cell
        collection.register(LBFMPlayCell.self, forCellWithReuseIdentifier: LBFMPlayCellID)
        collection.register(LBFMPlayCommentCell.self, forCellWithReuseIdentifier: LBFMPlayCommentCellID)
        collection.register(LBFMPlayAnchorCell.self, forCellWithReuseIdentifier: LBFMPlayAnchorCellID)
        collection.register(LBFMPlayCircleCell.self, forCellWithReuseIdentifier: LBFMPlayCircleCellID)
        return collection
    }()
    

    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton1:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_more_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton2:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_share_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var viewModel: LBFMPlayViewModel = {
        return LBFMPlayViewModel(albumId:self.albumId,trackUid:self.trackUid, uid:self.uid)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navBarBarTintColor = UIColor.white
        navBarBackgroundAlpha = 0
        self.view.addSubview(self.collectionView)
        self.collectionView.snp_makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
        let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        loadData()
    }
    
    func loadData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 0 {
            navBarBackgroundAlpha = 1
        } else {
            navBarBackgroundAlpha = 0
        }
    }
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick1() {
        
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }

}

extension LBFMPlayController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSections(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMPlayCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMPlayCellID, for: indexPath) as! LBFMPlayCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = YYNavigationController.init(rootViewController: FMPlayDetailController())
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : LBFMPlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMPlayHeaderViewID, for: indexPath) as! LBFMPlayHeaderView
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView : LBFMPlayFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMPlayFooterViewID, for: indexPath) as! LBFMPlayFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
}
