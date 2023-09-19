//
//  ToDoViewModel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import Combine
import Foundation

class ToDoViewModel {
    private var todoList = CurrentValueSubject<[Task], Never>([])
    var todoPublisher: AnyPublisher<[Task], Never> {
        return todoList.eraseToAnyPublisher()
    }

    var todos: [Task] = [] {
        didSet {
            todoList.send(todos)
        }
    }

    var totalCount: Int {
        return todos.count
    }

    func createItem(id: UUID, title: String, date: Date, modifyDate: Date?, isCompleted: Bool) {
        let newTask = Task(context: DataManager.context)
        newTask.id = id
        newTask.title = title
        newTask.date = Date()
        newTask.isCompleted = false

        todos.append(newTask)

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Insert Error: \(error)")
        }
    }

    func readItem() {
        do {
            todos = try DataManager.context.fetch(Task.fetchRequest())
            todoList.send(todos)
        } catch {
            // error
            print("패치 에러 : \(error)")
        }
    }

    func updateItem(task: Task, newTitle: String, modifyDate: Date) {
        task.title = newTitle
        task.modifyDate = modifyDate

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Update Error: \(error)")
        }
    }

    func deleteItem(at indexPath: Int) {
        let itemIndexPath = todos[indexPath]
        DataManager.context.delete(itemIndexPath)

        do {
            try DataManager.context.save()
            readItem()
            todoList.send(todos)
        } catch {
            print("### Delete Error: \(error)")
        }
    }
}
