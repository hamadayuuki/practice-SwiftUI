//
//  TaskViewModel.swift
//  TaskManagementApp
//
//  Created by 濵田　悠樹 on 2023/04/28.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    @Published var tappedDay = Date()
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "taskDescription", taskDate: Date()),
        Task(taskTitle: "Meeting", taskDescription: "taskDescription", taskDate: Date()),
        Task(taskTitle: "Meeting", taskDescription: "taskDescription", taskDate: Date()),
        Task(taskTitle: "Icon Set", taskDescription: "taskDescription", taskDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
        Task(taskTitle: "Proto Type", taskDescription: "taskDescription", taskDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
        Task(taskTitle: "Check Assets", taskDescription: "taskDescription", taskDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!),
        Task(taskTitle: "Team Party", taskDescription: "taskDescription", taskDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!),
    ]
    @Published var filteredTasks: [Task]?
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let current = Calendar.current
            let filterdTasks = self.storedTasks.filter {
                return current.isDate($0.taskDate, inSameDayAs: self.tappedDay)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filterdTasks
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else { return }
        
        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isTappedDay(date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: tappedDay)
    }
}
