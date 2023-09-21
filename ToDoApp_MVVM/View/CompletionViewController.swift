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
    var subscription = Set<AnyCancellable>()

    deinit {
        print("### CategoryViewController deinitalized")
    }
}

extension CompletionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.readItem()
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
    }

    func setupTableView() {
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

    func registerCell() {
        tableView.register(CompletionCell.self, forCellReuseIdentifier: CompletionCell.identifier)
    }
}

extension CompletionViewController {
    func bind() {
        viewModel.completedPublisher
            .receive(on: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink { [weak self] _ in
                print("### Combpletion 작동 중")
                print("### \(self?.viewModel.completedTodos)")
                self?.tableView.reloadData()
            }.store(in: &subscription)
    }
}

extension CompletionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.completedTodos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompletionCell.identifier, for: indexPath) as? CompletionCell else { return UITableViewCell() }
        cell.backgroundColor = .systemOrange
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItems(indexPath: indexPath.row)        }
    }
}
