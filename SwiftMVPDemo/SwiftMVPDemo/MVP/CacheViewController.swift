//
//  CacheViewController.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

class CacheViewController: UIViewController {

    private var cachePresenter = CachePresenter<CacheViewController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cachePresenter.initial(self)
        reloadData()
    }
    
    func reloadData() {
        /// 请求
        self.cachePresenter.getCache(by: 2000)
    }
}

/// 协议
extension CacheViewController: CacheProtocol {
    
    func getCacheSuccess(model: CacheModel?) {
        dump(model)
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.text = "\(model?.origin ?? "") \n \(model?.url ?? "")"
            label.numberOfLines = 2
            label.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 200)
            self.view.addSubview(label)
        }
    }
    
    func getCacheFailure(error: Error) {
        dump(error)
    }
}
