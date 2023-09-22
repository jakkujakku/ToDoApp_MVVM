//
//  CustomLabel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 18, weight: .bold)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ofSize: CGFloat, weight: UIFont.Weight, text: String, textAlignment: NSTextAlignment) {
        self.text = text
        self.font = .systemFont(ofSize: ofSize, weight: weight)
        self.textAlignment = textAlignment
    }
}
