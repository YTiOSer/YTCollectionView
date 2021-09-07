//
//  YTHomeDemoListCell.swift
//  YTCustomCollectionViewSwift
//
//  Created by YT on 2021/7/5.
//

import UIKit

class YTHomeDemoListCell: UICollectionViewCell {
    
    var cellModel: YTHomeDemoListCellModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
}

extension YTHomeDemoListCell: YTCollectionViewCellProtocol {
    
    func yt_cellWithData(itemModel: YTCollectionViewCellModelProtocol) {
        
        guard let cellModel = itemModel as? YTHomeDemoListCellModel else {return}
        
        self.cellModel = cellModel
        self.titleLabel.text = cellModel.model?.title
        self.contentLabel.text = cellModel.model?.content
    }
}

extension YTHomeDemoListCell {
    
    func createUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
        self.layoutUI()
    }
    
    func layoutUI() {
        self.titleLabel.frame = CGRect(x: 16, y: 16, width: 200, height: 20)
        self.contentLabel.frame = CGRect(x: 16, y: 44, width: 200, height: 20)
    }
}
