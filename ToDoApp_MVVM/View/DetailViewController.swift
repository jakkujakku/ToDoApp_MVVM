//
//  DetailViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/20.
//

import Combine
import SnapKit
import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    var subscription = Set<AnyCancellable>()

    let imageView = CustomImageView(frame: .zero)

    let titleLabel = CustomLabel(frame: .zero)
    let dateLabel = CustomLabel(frame: .zero)
    let modifiedDateLabel = CustomLabel(frame: .zero)

    let editButton = CustomButton(frame: .zero)
    let backButton = CustomButton(frame: .zero)

    deinit {
        print("### DetailViewController deinitialized")
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        bind()
    }
}

extension DetailViewController {
    func setup() {
        setupImageView()
        setupLabel()
    }

    func setupImageView() {
        imageView.image = UIImage(systemName: "bell")
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(250)
        }
    }

    func setupLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(50)
        }
    }

    func bind() {
        viewModel.detailPublisher
            .receive(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.titleLabel.text = self?.viewModel.title
                print("### \(self?.viewModel.item)")
            }.store(in: &subscription)
    }
}
