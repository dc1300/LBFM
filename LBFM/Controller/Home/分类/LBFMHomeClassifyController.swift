//
//  LBFMHomeClassifyController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/7.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMHomeClassifyController: UIViewController {

    private let LBFMCellIdentifier = "LBFMHomeClassifyCell"
    private let LBFMHomeClassifyFooterViewID = "LBFMHomeClassifyFooterView"
    private let LBFMHomeClassifyHeaderViewID = "LBFMHomeClassifyHeaderView"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(LBFMHomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMHomeClassifyHeaderViewID)
        collection.register(LBFMHomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMHomeClassifyFooterViewID)
        collection.register(LBFMHomeClassifyCell.self, forCellWithReuseIdentifier: LBFMCellIdentifier)
        collection.backgroundColor = LBFMDownColor
        return collection
    }()
    
    lazy var viewModel:LBFMHomeClassifyViewModel = {
        return LBFMHomeClassifyViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.collectionView)
        self.collectionView.snp_makeConstraints { (make) in
            make.left.top.right.height.equalToSuperview()
        }
        setupLoadData()
    }
    
    func setupLoadData()  {
        viewModel.updataBlock = {
         self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}


extension LBFMHomeClassifyController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBFMHomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMCellIdentifier, for: indexPath) as! LBFMHomeClassifyCell
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.layer.borderColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        cell.layer.borderWidth = 0.5
        
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryId:Int = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.categoryId ?? 0
        let title = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.title ?? ""
        print("----\(categoryId)-- \(title)---")
    }
    
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
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
            let headerView : LBFMHomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMHomeClassifyHeaderViewID, for: indexPath) as! LBFMHomeClassifyHeaderView
            headerView.titleString = viewModel.classifyModel?[indexPath.section].groupName
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView : LBFMHomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LBFMHomeClassifyFooterViewID, for: indexPath) as! LBFMHomeClassifyFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
