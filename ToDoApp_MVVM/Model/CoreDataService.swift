//
//  CoreDataService.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/19.
//

import UIKit

class CoreDataService {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
