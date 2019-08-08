//
//  LBFMClassifySubVerticalCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMClassifySubVerticalCell: UICollectionViewCell {
    //图片
    private var picView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    //标题
    private var titleLabel: UILabel = {
       let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    //是否完结
    private var paidLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.init(red: 248, green: 210, blue: 74, alpha: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 播放数量
    private var numLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 集数
    private var tracksLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 播放数量图片
    private var numView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playcount.png")
        return imageView
    }()
    
    // 集数图片
    private var tracksView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "track.png")
        return imageView
    }()
    
    
    
    var classifyVerticalModel:LBFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            self.picView.kf.setImage(with: URL(string: model.coverMiddle!))
            if model.isPaid {
                self.paidLabel.isHidden = true
                self.paidLabel.snp.updateConstraints { (make) in
                    make.width.equalTo(0)
                }
                self.titleLabel.snp.updateConstraints { (make) in
                    make.left.equalTo(self.paidLabel.snp.right)
                }
            }
            self.titleLabel.text = model.title
            self.subLabel.text = model.intro
            self.tracksLabel.text = "\(model.tracks)集"
            var tagString:String?
            if model.playsCounts > 100000000 {
                tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
            } else if model.playsCounts > 10000 {
                tagString = String(format: "%.1f万", Double(model.playsCounts) / 10000)
            } else {
                tagString = "\(model.playsCounts)"
            }
            self.numLabel.text = tagString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
