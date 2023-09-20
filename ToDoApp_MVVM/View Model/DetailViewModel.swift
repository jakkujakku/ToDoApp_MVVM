//
//  DetailViewModel.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/20.
//

import Foundation
import Combine

class DetailViewModel {
    private var detailItem = CurrentValueSubject<Task?, Never>(nil)
    var detailPublisher: AnyPublisher<Task?, Never> {
        return detailItem.eraseToAnyPublisher()
    }
    
    var item: Task? = nil
    
    var title: String {
        return item?.title ?? ""
    }
    
    var date: String {
        return DataManager.dateFormatter(date: item?.date ?? Date())
    }
    
    var modified: String {
        return DataManager.dateFormatter(date: item?.modifyDate ?? Date())
    }
}
