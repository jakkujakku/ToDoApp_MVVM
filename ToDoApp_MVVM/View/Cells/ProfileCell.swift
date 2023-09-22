//
//  ProfileCell.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/22.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    static let identifier = "ProfileCell"

    var imageview = CustomImageView(frame: .zero)
    var mockup = MockupData.list
    
    func setupUI() {
        contentView.addSubview(imageview)
        imageview.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(contentView)
        }
    }
    
    func configureCell(indexPath: Int) {
        imageview.image = UIImage(named: mockup[indexPath].string)
    }
}
