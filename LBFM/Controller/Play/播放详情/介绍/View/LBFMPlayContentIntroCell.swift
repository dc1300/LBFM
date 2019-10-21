//
//  LBFMPlayContentIntroCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/10/18.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMPlayContentIntroCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.text = "内容简介"
        return label
    }()
    
    //内容详情
    private lazy var subLabel : UILabel = {
        let label = LBFMCustomLabel.init()
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.bottom.right.equalToSuperview().offset(-15)
        }
    }
    var playDetailAlbumModel:LBFMPlayDetailAlbumModel?{
        didSet{
            guard let model = playDetailAlbumModel else {
                return
            }
            self.subLabel.text = model.shortIntro
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
