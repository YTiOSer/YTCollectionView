//
//  ViewController.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let vc = EHIHomeDemoViewController()
        self.view.addSubview(vc.view)
    }
}

