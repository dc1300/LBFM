//
//  LBFMHomeClassifyHeaderView.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMHomeClassifyHeaderView: UICollectionReusableView {
    lazy var view: UIView = {
        let view = UIView.init()
        view.backgroundColor = LBFMButtonColor
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = LBFMDownColor
        self.addSubview(self.view)
        self.addSubview(self.titleLabel)
        self.view.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    var titleString: String? {
        didSet{
            guard let str = titleString else {
                return
            }
            self.titleLabel.text = str
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
