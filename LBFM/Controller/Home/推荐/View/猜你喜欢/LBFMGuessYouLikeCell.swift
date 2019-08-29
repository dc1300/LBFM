//
//  LBFMGuessYouLikeCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/29.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMGuessYouLikeCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subLabel)
        self.imageView.snp_makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        self.subLabel.snp_makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommendData:LBFMRecommendListModel? {
        didSet{
            guard let model = recommendData else { return }
            if (model.pic != nil) {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLabel.text = model.title
            self.subLabel.text = model.subtitle
        }
    }
}
