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
    private let profileButton = CustomButton()

    private let logoImageView = CustomImageView(frame: .zero)

    private let categoryVC = CategoryViewController()
    private let completedVC = CompletionViewController()
    private let profileVC = ProfileViewController()

    deinit {
        print("### MainViewController deinitialized")
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
        todoButton.configure(title: "TO DO", color: .systemPink)
        completionButton.configure(title: "COMPLE", color: .systemOrange)
        profileButton.configure(title: "PROFILE", color: .systemGreen)
        todoButton.applyConerRadius()
        completionButton.applyConerRadius()
        profileButton.applyConerRadius()

        todoButton.addTarget(self, action: #selector(tappedCategoryButton(_:)), for: .touchUpInside)
        completionButton.addTarget(self, action: #selector(tappedCompletionButton(_:)), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(tappedProfileButton(_:)), for: .touchUpInside)

        [todoButton, completionButton, profileButton].forEach {
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
            make.top.equalTo(todoButton.snp.bottom).offset(60)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }

        profileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(completionButton.snp.bottom).offset(60)
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
    }

    @objc func tappedCompletionButton(_ sender: UIButton) {
        navigationController?.pushViewController(completedVC, animated: true)
    }

    @objc func tappedProfileButton(_ sender: UIButton) {
        print("### \(#function)")
        profileVC.modalPresentationStyle = .overFullScreen
        present(profileVC, animated: true)
    }
}
