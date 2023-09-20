//
//  ToDoViewModel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import Combine
import CoreData
import Foundation

class ToDoViewModel {
    private var todoList = CurrentValueSubject<[Task], Never>([])
    private var selectedItem = CurrentValueSubject<Task?, Never>(nil)

    var todoPublisher: AnyPublisher<[Task], Never> {
        return todoList.eraseToAnyPublisher()
    }

    var selectedPublisher: AnyPublisher<Task?, Never> {
        return selectedItem.eraseToAnyPublisher()
    }

    var todos: [Task] = [] {
        didSet {
            todoList.send(todos)
        }
    }

    var selectedCategory: Category? {
        didSet {
            readItem()
        }
    }

    var totalCount: Int {
        return todos.count
    }

    func didSelecteItem(at indexPath: Int) {
        print("### \(#function)")
        let item = todos[indexPath]
        selectedItem.send(item)
    }

    func createItem(id: UUID, title: String, date: Date, modifyDate: Date?, isCompleted: Bool) {
        let newTask = Task(context: DataManager.context)
        newTask.id = id
        newTask.title = title
        newTask.date = Date()
        newTask.isCompleted = false
        newTask.parentCategory = selectedCategory
        todos.append(newTask)

        do {
            try DataManager.context.save()
            todoList.send(todos)
        } catch {
            print("### Insert Error: \(error)")
        }
    }

    func readItem(with request: NSFetchRequest<Task> = Task.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)

        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        do {
            todos = try DataManager.context.fetch(request)

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
