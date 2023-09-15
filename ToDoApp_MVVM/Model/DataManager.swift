//
//  DataManager.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import UIKit

class DataManager {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    func loadData() {
//        do {
//            todos = try DataManager.context.fetch()
//        }
//        catch {
//            // error
//            print("패치 에러 : \(error)")
//        }
//    }
//
//    // Create Item
//    func saveData(item: String) {
//        var newData = ToDo
//        newData.description = item
//
//        do {
//            try DataManager.context.save()
//            loadData()
//        }
//        catch {
//            print("삽입 에러 : \(error)")
//        }
//    }
//
//    // Update Item
//    func updateData(data: ToDo, newName: String) {
//        data.description = newName
//        do {
//            try DataManager.context.save()
//            loadData()
//        }
//        catch {
//            print("업데이트 에러 : \(error)")
//        }
//    }
//
//    // Delete Item(부분 삭제)
//    func deleteData(at indexPath: IndexPath) {
//        let dataIndexPath = todos[indexPath.row]
//        DataManager.context.delete(dataIndexPath)
//
//        do {
//            try DataManager.context.save()
//            loadData()
//        }
//        catch {
//            print("부분 삭제 에러 : \(error)")
//        }
//    }
}
