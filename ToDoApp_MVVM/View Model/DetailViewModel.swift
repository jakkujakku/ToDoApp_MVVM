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
}
