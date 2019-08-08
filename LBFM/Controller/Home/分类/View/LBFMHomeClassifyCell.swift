//
//  LBFMHomeClassifyCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMHomeClassifyCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lable = UILabel.init()
        lable.font = UIFont.systemFont(ofSize: 15)
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.imageView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp_right).offset(5)
            make.top.bottom.equalTo(self.imageView)
            make.width.equalToSuperview().offset(-self.imageView.frame.width)
        }
        
    }
    
    
    var itemModel:LBFMItemList? {
        didSet{
            guard let model = itemModel else {
                return
            }
            if model.itemType == 1 {
                ///第一个item,有图片显示m，文字o偏小
                self.titleLabel.text = model.itemDetail?.keywordName
            }else{
                self.titleLabel.text = model.itemDetail?.title
                self.imageView.kf.setImage(with: URL.init(string: model.coverPath!))
            }
            
            
        }
    }
    
    // 前三个分区第一个item的字体较小
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else{
                return
            }
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
                if indexPath.row == 0 {
                    self.titleLabel.font = UIFont.systemFont(ofSize: 13)
                }
            }
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}
