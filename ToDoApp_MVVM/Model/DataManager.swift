//
//  DataManager.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import UIKit

class ToDoManager {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension ToDoManager {
    static func loadData() {
        do {
            ToDoManager.tasks = try ToDoManager.context.fetch(Task.fetchRequest())
        }
        catch {
            // error
            print("패치 에러 : \(error)")
        }
    }

    // Create Item
    static func saveData(item: String) {
        var newData = ToDo(context: ToDoManager.context)
        newData.work = item

        do {
            try ToDoManager.context.save()
            loadData()
        }
        catch {
            print("삽입 에러 : \(error)")
        }
    }

    // Update Item
    static func updateData(data: ToDo, newName: String) {
        data.work = newName
        do {
            try ToDoManager.context.save()
            ToDoManager.loadData()
        }
        catch {
            print("업데이트 에러 : \(error)")
        }
    }

    // Delete Item(부분 삭제)
    static func deleteData(at indexPath: IndexPath) {
        let dataIndexPath = ToDoManager.todos[indexPath.row]
        ToDoManager.context.delete(dataIndexPath)

        do {
            try ToDoManager.context.save()
            ToDoManager.loadData()
        }
        catch {
            print("부분 삭제 에러 : \(error)")
        }
    }
}
