//
//  CategoryCell.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import SnapKit
import UIKit

final class CategoryCell: UITableViewCell {
    static var identifier = "CategoryCell"

    var titleLabel = CustomLabel(frame: .zero)
}

extension CategoryCell {
    func configure(item: Category) {
        titleLabel.text = item.title
    }

    func setupUI() {
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }
}
