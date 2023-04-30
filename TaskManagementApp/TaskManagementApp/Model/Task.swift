//
//  Task.swift
//  TaskManagementApp
//
//  Created by 濵田　悠樹 on 2023/04/30.
//

import Foundation

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
