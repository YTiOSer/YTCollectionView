//
//  ViewController.swift
//  YTCollectionView
//
//  Created by yt on 2021/8/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = YTHomeDemoViewController()
        self.view.addSubview(vc.view)
    }


}

