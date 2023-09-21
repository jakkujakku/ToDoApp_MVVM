//
//  ProfileViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileIconimageView = CustomImageView(frame: .zero)
    
    deinit {
        print("### ProfileViewController deinitialized")
    }
}

extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
