//
//  CategoryViewModel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import Combine
import Foundation

class CategoryViewModel {
    private var categoriesList = CurrentValueSubject<[Category], Never>([])
    var categoriesPublisher: AnyPublisher<[Category], Never> {
        return categoriesList.eraseToAnyPublisher()
    }

    var categories: [Category] = [] {
        didSet {
            categories.sort(by: { $0.title! > $1.title! })
            categoriesList.send(categories)
        }
    }

    var totalCount: Int {
        return categories.count
    }

    func createItem(id: UUID, title: String) {
        let newCategory = Category(context: DataManager.context)
        newCategory.id = id
        newCategory.title = title

        categories.append(newCategory)

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Insert Error: \(error)")
        }
    }

    func readItem() {
        do {
            categories = try DataManager.context.fetch(Category.fetchRequest())
            categoriesList.send(categories)
        } catch {
            // error
            print("Fetch 에러 : \(error)")
        }
    }

    func updateItem(category: Category, newTitle: String) {
        category.title = newTitle

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Update Error: \(error)")
        }
    }

    func deleteItem(at indexPath: Int) {
        let itemIndexPath = categories[indexPath]
        DataManager.context.delete(itemIndexPath)

        do {
            try DataManager.context.save()
            readItem()
            categoriesList.send(categories)
        } catch {
            print("### Delete Error: \(error)")
        }
    }

    func deleteItems() {
        for category in categories {
            DataManager.context.delete(category)
        }

        do {
            try DataManager.context.save()
            readItem()
            categoriesList.send(categories)
        } catch {
            print("### Delete Error: \(error)")
        }
    }
}
