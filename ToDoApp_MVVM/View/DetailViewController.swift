//
//  DetailViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/20.
//

import Combine
import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    var subscription = Set<AnyCancellable>()

    deinit {
        print("### DetailViewController deinitialized")
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        setup()
    }
}

extension DetailViewController {
    func setup() {
        bind()
    }

    func bind() {
        viewModel.detailPublisher
            .receive(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                print("### \(self?.viewModel.item)")
            }.store(in: &subscription)
    }
}
