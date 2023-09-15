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
    // 1. 테이블 뷰 UI 구현 ✅
    // 2. CoreData 추가
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)
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
        DataManager.context
        setupTableView()
        registerCell()
        setupBarButtonItem()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .systemPink

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
}

private extension ToDoViewController {
    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        print("### \(#function)")
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        cell.backgroundColor = .systemOrange
        return cell
    }
}
