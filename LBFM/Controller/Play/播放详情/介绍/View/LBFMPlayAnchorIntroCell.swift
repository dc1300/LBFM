//
//  LBFMPlayAnchorIntroCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/10/18.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMPlayAnchorIntroCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.text = "主播介绍"
        return label
    }()
    
    private lazy var iconView : UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var attentionLabel : UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var attentionButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "np_headview_nofollow_n_23x36_"), for: UIControl.State.normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier   )
    }
    
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        self.addSubview(self.iconView)
        self.iconView.layer.masksToBounds = true
        self.iconView.layer.cornerRadius = 24
        self.iconView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.width.height.equalTo(48)
        }
        self.addSubview(self.nickNameLabel)
        self.nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(10)
            make.top.equalTo(self.iconView.snp.top).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        self.addSubview(self.attentionLabel)
        self.attentionLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(23)
            make.top.equalTo(self.iconView)
        }
    }
    
    var playDetailUserModel : LBFMPlayDetailUserModel?{
        didSet{
            guard let model = playDetailUserModel else {
                return
            }
            self.iconView.kf.setImage(with:  URL(string: model.smallLogo!))
            self.nickNameLabel.text = model.nickname
            var tagString : String
            if model.followers > 100000000{
                tagString = String(format: "%.1f亿", Double(model.followers) / 100000000)
            } else if model.followers > 10000 {
                tagString = String(format: "%.1f万", Double(model.followers) / 10000)
            } else {
                tagString = "\(model.followers)"
            }
            self.attentionLabel.text = "已被\(tagString)人关注"
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
