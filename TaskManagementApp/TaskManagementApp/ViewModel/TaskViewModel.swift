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
    
    init() {
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else { return }
        
        (1...7).forEach { day in
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
