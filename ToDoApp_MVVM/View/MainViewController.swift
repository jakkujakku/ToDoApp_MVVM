//
//  MainViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/14.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let todoButton = CustomButton()
    private let completionButton = CustomButton()
    private let logoImageView = CustomImageView(frame: .zero)

    private let categoryVC = CategoryViewController()
    private let completedVC = CompletionViewController()

    deinit {
        print("### ")
    }
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension MainViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        setupButtons()
        setupImageView()
    }

    func setupButtons() {
        todoButton.configure(title: "할 일 추가", color: .systemPink)
        completionButton.configure(title: "완료한 일", color: .systemOrange)
        todoButton.applyConerRadius()
        completionButton.applyConerRadius()

        todoButton.addTarget(self, action: #selector(tappedCategoryButton(_:)), for: .touchUpInside)
        completionButton.addTarget(self, action: #selector(tappedCompletionButton(_:)), for: .touchUpInside)

        [todoButton, completionButton].forEach {
            view.addSubview($0)
        }

        todoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalToSuperview().offset(80)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }

        completionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(todoButton.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
    }

    func setupImageView() {
        logoImageView.image = UIImage(named: "Logo.png")
        logoImageView.configurelayer(corner: 10)
        logoImageView.contentMode = .scaleToFill

        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.equalTo(view.safeAreaInsets).inset(40)
        }
    }
}

private extension MainViewController {
    @objc func tappedCategoryButton(_ sender: UIButton) {
        navigationController?.pushViewController(categoryVC, animated: true)
        print("### \(#function)")
    }

    @objc func tappedCompletionButton(_ sender: UIButton) {
        navigationController?.pushViewController(completedVC, animated: true)
        print("### \(#function)")
    }
}
