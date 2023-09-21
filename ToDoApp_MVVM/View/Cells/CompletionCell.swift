//
//  CompletionCell.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import UIKit
import SnapKit

class CompletionCell: UITableViewCell {
    static let identifier = "CompletionCell"
    var titleLabel = CustomLabel(frame: .zero)
}

extension CompletionCell {
    override func awakeFromNib() {}
}

extension CompletionCell {
    func configure(item: Completion) {
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
