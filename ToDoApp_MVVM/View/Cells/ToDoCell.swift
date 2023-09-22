//
//  ToDoCell.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import SnapKit
import UIKit

final class ToDoCell: UITableViewCell {
    static let identifier = "ToDoCell"

    var titleLabel = CustomLabel(frame: .zero)
}

extension ToDoCell {
    override func awakeFromNib() {}
}

extension ToDoCell {
    func configure(item: Task) {
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
