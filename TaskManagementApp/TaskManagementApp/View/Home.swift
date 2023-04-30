//
//  Home.swift
//  TaskManagementApp
//
//  Created by 濵田　悠樹 on 2023/04/28.
//

import SwiftUI

struct Home: View {
    @StateObject var taskViewModel = TaskViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: Lazy Stack With Pinned Heeader
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(taskViewModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    Text(taskViewModel.extractDate(date: day, format: "dd"))
                                    Text(taskViewModel.extractDate(date: day, format: "EEE"))
                                    
                                    Capsule()
                                        .fill(.white)
                                        .frame(width: 10, height: 10)
                                        .opacity(taskViewModel.isTappedDay(date: day) ? 1.0 : 0.0)
                                }
                                .foregroundColor(taskViewModel.isTappedDay(date: day) ? .white : .black)
                                .frame(width: 50, height: 100)
                                .background(
                                    ZStack {
                                        if taskViewModel.isTappedDay(date: day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .onTapGesture {
                                    withAnimation {
                                        taskViewModel.tappedDay = day
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                    if let tasks = taskViewModel.filteredTasks {
                        if tasks.isEmpty {
                            Text("filteredTasks is Empty")
                        } else {
                            ForEach(tasks) { task in
                                TaskCardView(task: task)
                            }
                        }
                    } else { }
                } header: {
                    HeaderView()
                        .background(.white)
                }
            }
            .onChange(of: taskViewModel.tappedDay) { newValue in
                taskViewModel.filterTodayTasks()
            }
        }
    }
    
    // MARK: Header
    private func  HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("Statue_of_liberty_Flatline")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(.gray, lineWidth: 1.0)
                            .frame(width: 60, height: 60)
                     )
            }
        }
        .padding()
    }
    
    private func TaskCardView(task: Task) -> some View {
        Text(task.taskTitle)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// MARK: UI Design Helper functions
extension View {
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
