//
//  ToDoViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/14.
//

import Combine
import CoreData
import SnapKit
import UIKit

class ToDoViewController: UIViewController {
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)
    var viewModel = ToDoViewModel()
    var subscription = Set<AnyCancellable>()

    deinit {
        print("ToDoViewController deinitalized")
    }
}

extension ToDoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension ToDoViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        viewModel.readItem()
        setupTableView()
        registerCell()
        setupBarButtonItem()
        bind()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .plain, target: self, action: #selector(tappedAddButton(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    func registerCell() {
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.identifier)
    }

    func bind() {
        viewModel.todoPublisher
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscription)
    }
}

private extension ToDoViewController {
    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        viewModel.createItem(id: UUID(), title: "둘리", date: Date(), modifyDate: nil, isCompleted: false)
        print("### \(#function)")
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        cell.backgroundColor = .systemOrange
        return cell
    }
}

extension ToDoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {}
    }
}
