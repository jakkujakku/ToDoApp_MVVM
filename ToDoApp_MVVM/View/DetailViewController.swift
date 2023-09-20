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
    var viewModel = ToDoViewModel()
    var subscription = Set<AnyCancellable>()

    let superStackView = CustomStackView(frame: .zero)
    let titleStackView = CustomStackView(frame: .zero)
    let dateStackView = CustomStackView(frame: .zero)
    let modifiedStackView = CustomStackView(frame: .zero)

    let imageView = CustomImageView(frame: .zero)

    let titleDescription = CustomLabel(frame: .zero)
    let titleLabel = CustomLabel(frame: .zero)
    let dateDescription = CustomLabel(frame: .zero)
    let dateLabel = CustomLabel(frame: .zero)
    let modifiedDascription = CustomLabel(frame: .zero)
    let modifiedDateLabel = CustomLabel(frame: .zero)

    let editButton = CustomButton(frame: .zero)

    deinit {
        print("### DetailViewController deinitialized")
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        bind()
    }
}

private extension DetailViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        setupStackView()
        setupImageView()
        setupTitleStackView()
        setupDateStackView()
        setupModifiedStackView()
        setButton()
    }

    func setupStackView() {
        superStackView.configure(axis: .vertical, alignment: .fill, distribution: .fillProportionally, spacing: 20)
        view.addSubview(superStackView)

        [imageView, titleStackView, dateStackView, modifiedStackView, editButton].forEach { superStackView.addArrangedSubview($0) }

        superStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    func setupImageView() {
        imageView.image = UIImage(systemName: "bell")
        imageView.contentMode = .scaleAspectFit

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(superStackView)
            make.leading.equalToSuperview()
            make.height.equalTo(80)
        }
    }

    func setupTitleStackView() {
        titleDescription.configure(ofSize: 20, weight: .bold, text: "TITLE :", textAlignment: .center)
        titleLabel.configure(ofSize: 20, weight: .bold, text: viewModel.title, textAlignment: .center)

        [titleDescription, titleLabel].forEach { titleStackView.addArrangedSubview($0) }

        titleStackView.configure(axis: .horizontal, alignment: .fill, distribution: .equalSpacing, spacing: 0)

        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }

    func setupDateStackView() {
        dateDescription.configure(ofSize: 20, weight: .bold, text: "DATE :", textAlignment: .center)
        dateLabel.configure(ofSize: 20, weight: .bold, text: viewModel.title, textAlignment: .center)

        [dateDescription, dateLabel].forEach { dateStackView.addArrangedSubview($0) }

        dateStackView.configure(axis: .horizontal, alignment: .fill, distribution: .equalSpacing, spacing: 0)

        dateStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }

    func setupModifiedStackView() {
        modifiedDascription.configure(ofSize: 20, weight: .bold, text: "MODIFIED DATE :", textAlignment: .center)
        modifiedDateLabel.configure(ofSize: 20, weight: .bold, text: viewModel.title, textAlignment: .center)

        [modifiedDascription, modifiedDateLabel].forEach { modifiedStackView.addArrangedSubview($0) }

        modifiedStackView.configure(axis: .horizontal, alignment: .fill, distribution: .equalSpacing, spacing: 0)

        modifiedStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }

    func setButton() {
        editButton.configure(title: "Edit Button", color: .systemOrange)
        editButton.addTarget(self, action: #selector(tappedEditButton(_:)), for: .touchUpInside)
        editButton.applyConerRadius()
        editButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}

private extension DetailViewController {
    func bind() {
        viewModel.detailPublisher
            .receive(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.titleLabel.text = self?.viewModel.title
                self?.dateLabel.text = self?.viewModel.date
                self?.modifiedDateLabel.text = self?.viewModel.modified
            }.store(in: &subscription)
    }
}

private extension DetailViewController {
    @objc func tappedEditButton(_ sender: UIButton) {
        showAlert()
        print("### \(#function)")
    }

    func showAlert() {
        let alert = UIAlertController(title: "Please enter a category", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)

        let confirmAlert = UIAlertAction(title: "추가", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.viewModel.updateItem(task: self?.viewModel.item, newTitle: text, modifyDate: self?.viewModel.item?.modifyDate ?? Date())
            self?.navigationController?.popViewController(animated: true)
        })

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)
        present(alert, animated: true)
    }
}
