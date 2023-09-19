//
//  DataManager.swift
//  ToDoApp_MVVM
//
//  Created by (^ㅗ^)7 iMac on 2023/09/15.
//

import Foundation
import UIKit

class DataManager {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d a hh:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
