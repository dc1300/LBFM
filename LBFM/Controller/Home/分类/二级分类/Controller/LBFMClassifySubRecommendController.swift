//
//  LBFMClassifySubRecommendController.swift
//  LBFM
//
//  Created by 戴晨 on 2019/8/8.
//  Copyright © 2019 戴晨. All rights reserved.
//

import UIKit

class LBFMClassifySubRecommendController: UIViewController {
    private var categoryId: Int = 0
    convenience init(categoryId:Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
