//
//  ViewController.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(CacheViewController(), animated: true)
    }
}

