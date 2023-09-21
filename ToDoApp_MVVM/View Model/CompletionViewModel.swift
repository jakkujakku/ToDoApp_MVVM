//
//  CompletionViewModel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import Combine
import Foundation

class CompletionViewModel {
    private var completedList = CurrentValueSubject<[Completion], Never>([])
    var completedPublisher: AnyPublisher<[Completion], Never> {
        return completedList.eraseToAnyPublisher()
    }

    var completedTodos: [Completion] = [] {
        didSet {
            completedList.send(completedTodos)
        }
    }

    var totalCount: Int {
        return completedTodos.count
    }

    func createItem(title: String) {
        let newItem = Completion(context: DataManager.context)
        newItem.title = title
        completedTodos.append(newItem)

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Insert Error: \(error)")
        }
    }

    func readItem() {
        do {
            completedTodos = try DataManager.context.fetch(Completion.fetchRequest())
            completedList.send(completedTodos)
        } catch {
            // error
            print("패치 에러 : \(error)")
        }
    }

    func deleteItems(indexPath: Int) {
        DataManager.context.delete(completedTodos[indexPath])

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Delete Error: \(error)")
        }
    }
}
