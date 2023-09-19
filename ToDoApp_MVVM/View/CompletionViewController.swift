//
//  CompletionViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/14.
//

import Combine
import CoreData
import SnapKit
import UIKit

class CompletionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    deinit {
        print("### CategoryViewController deinitalized")
    }
}
