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
    var trashButton = CustomButton(frame: .zero)

    let vc = DetailViewController()

    var viewModel = ToDoViewModel()
    var completionViewModel = CompletionViewModel()
    var subscription = Set<AnyCancellable>()

    deinit {
        print("### ToDoViewController deinitalized")
    }
}

extension ToDoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.selectedCategory?.title
        bind()
    }
}

private extension ToDoViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.readItem()
        setupTableView()
        registerCell()
        setupBarButtonItem()
        setupTrashButton()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .plain, target: self, action: #selector(tappedAddButton(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    func setupTrashButton() {
        trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        trashButton.tintColor = .white
        trashButton.layer.cornerRadius = 40
        trashButton.layer.masksToBounds = true
        trashButton.backgroundColor = .systemPink

        trashButton.addTarget(self, action: #selector(tappedTrashButton(_:)), for: .touchUpInside)

        view.addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.width.equalTo(80)
        }
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

        viewModel.selectedPublisher
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] task in
                self?.vc.viewModel.item = task
            }.store(in: &subscription)
    }
}

private extension ToDoViewController {
    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        showAlert()
    }

    @objc func tappedTrashButton(_ sender: UIButton) {
        deleteAlert()
        print("### \(#function)")
    }

    func deleteAlert() {
        let alert = UIAlertController(title: "DO YOU WANT TO DELETE ALL DATA?", message: "", preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "DELETE", style: .default, handler: { [weak self] _ in
            self?.viewModel.deleteItems()
        })

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)
        present(alert, animated: true)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Please enter a Todo", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)

        let confirmAlert = UIAlertAction(title: "ADD", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.viewModel.createItem(id: UUID(), title: text.uppercased(), date: Date(), modifyDate: nil, isCompleted: false)
        })

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)
        present(alert, animated: true)
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        cell.setupUI()
        cell.configure(item: viewModel.todos[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(navigationItem.title!) todolist : \(viewModel.totalCount)"
    }
}

extension ToDoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelecteItem(at: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let confirm = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            success(true)
            self?.completionViewModel.createItem(title: self?.viewModel.todos[indexPath.row].title ?? "n/a")
            self?.viewModel.deleteItem(at: indexPath.row)
            print("### \(#function)")
        }
        confirm.backgroundColor = .systemBlue
        confirm.image = UIImage(systemName: "checkmark.message")

        return UISwipeActionsConfiguration(actions: [confirm])
    }
}
