//
//  LBFMPlayCell.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/9.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit
import StreamingKit

class LBFMPlayCell: UICollectionViewCell {
    var playUrl:String?
    var timer: Timer?
    var displayLink: CADisplayLink?
    private var isFirstPlay:Bool = true
    private lazy var audioPlayer : STKAudioPlayer = {
       let audioPlayer = STKAudioPlayer.init()
        return audioPlayer
    }()
    //标题
    private var titleLable:UILabel = {
        let lable = UILabel.init()
        lable.textAlignment = NSTextAlignment.center
        lable.numberOfLines = 0
        lable.font = UIFont.systemFont(ofSize: 20)
        return lable
    }()
    //图片
    private lazy var imageView:UIImageView = {
       let imageView = UIImageView.init()
        return imageView
    }()
    //弹幕按钮
    private lazy var barrageBtn: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "NPProDMOff_24x24_"), for: UIControl.State.normal)
        return button
    }()
    //播放机器按钮
    private lazy var machineBtn: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "npXPlay_30x30_"), for: UIControl.State.normal)
        return button
    }()
    // 设置按钮
    private lazy var setBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "NPProSet_25x24_"), for: UIControl.State.normal)
        return button
    }()
    
    
}
