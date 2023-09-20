//
//  ToDoCell.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import UIKit
import SnapKit

final class ToDoCell: UITableViewCell {
    static let identifier = "ToDoCell"

    var titleLabel = CustomLabel(frame: .zero)
    let completedSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        return uiSwitch
    }()
}

extension ToDoCell {
    func configure(item: Task) {
        titleLabel.text = item.title
    }

    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(completedSwitch)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        completedSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
