//
//  CategoryViewController.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import Combine
import CoreData
import SnapKit
import UIKit

class CategoryViewController: UIViewController {
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)
    var trashButton = CustomButton(frame: .zero)

    var todoVC = ToDoViewController()
    var viewModel = CategoryViewModel()
    var subscription = Set<AnyCancellable>()

    deinit {
        print("### CategoryViewController deinitalized")
    }
}

extension CategoryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        bind()
    }
}

extension CategoryViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Category"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = .clear
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
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }

    func bind() {
        viewModel.categoriesPublisher
            .subscribe(on: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscription)
    }
}

extension CategoryViewController {
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
        let alert = UIAlertController(title: "Please enter a category", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)

        let confirmAlert = UIAlertAction(title: "ADD", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.viewModel.createItem(id: UUID(), title: text.uppercased())
        })

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)
        present(alert, animated: true)
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        cell.setupUI()
        cell.configure(item: viewModel.categories[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Categories: \(viewModel.categories.count)"
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoVC.viewModel.selectedCategory = viewModel.categories[indexPath.row]
        navigationController?.pushViewController(todoVC, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
