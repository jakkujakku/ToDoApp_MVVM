//
//  CustomButton.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/14.
//

import UIKit

final class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("### Button deinitilized")
    }
}

extension CustomButton {
    func configure(title: String, color: UIColor) {
        setTitle(title, for: .normal)
        backgroundColor = color
        titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }

    func applyConerRadius() {
        layer.cornerRadius = 10
    }
}
