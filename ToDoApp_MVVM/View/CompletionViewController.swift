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
    var viewModel = CompletionViewModel()
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)
    var trashButton = CustomButton(frame: .zero)
    var subscription = Set<AnyCancellable>()

    deinit {
        print("### CategoryViewController deinitalized")
    }
}

extension CompletionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        bind()
    }
}

extension CompletionViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
        registerCell()
        setupTrashButton()
    }

    func setupTableView() {
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

    func setupTrashButton() {
        trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        trashButton.tintColor = .white
        trashButton.layer.cornerRadius = 40
        trashButton.layer.masksToBounds = true
        trashButton.backgroundColor = .systemOrange

        trashButton.addTarget(self, action: #selector(tappedTrashButton(_:)), for: .touchUpInside)

        view.addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.width.equalTo(80)
        }
    }

    func registerCell() {
        tableView.register(CompletionCell.self, forCellReuseIdentifier: CompletionCell.identifier)
    }
}

extension CompletionViewController {
    func bind() {
        viewModel.readItem()

        viewModel.completedPublisher
            .receive(on: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink { [weak self] _ in
                print("### Combpletion 작동 중")
                self?.tableView.reloadData()
            }.store(in: &subscription)
    }

    func deleteAlert() {
        let alert = UIAlertController(title: "DO YOU WANT TO DELETE ALL DATA?", message: "", preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "DELETE", style: .default, handler: { [weak self] _ in
            self?.viewModel.deleteAllItem()
        })

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)
        present(alert, animated: true)
    }

    @objc func tappedTrashButton(_ sender: UIButton) {
        deleteAlert()
        print("### \(#function)")
    }
}

extension CompletionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompletionCell.identifier, for: indexPath) as? CompletionCell else { return UITableViewCell() }
        cell.setupUI()
        cell.configure(item: viewModel.completedTodos[indexPath.row])
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItems(indexPath: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Completed TodoList : \(viewModel.totalCount)"
    }
}
