//
//  PlusViewModelProtocol.swift
//  TimeStacks
//
//  Created by asong on 2023/04/09.
//

import Foundation

protocol PlusViewModelType:  ObservableObject, Identifiable {
    var stackTitle: String { get set }
    var newStackItem: StackItem { get set }
    
    func calculateTopOffset(index: CGFloat) -> CGFloat
    func saveNewTimeStackItem()
}

class StackItem {
    // MARK: - Properties - Private
    
    @Published var title: String = ""
    @Published var isTimerVersion = true
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var timerTime: Date = Date()
    
    // MARK: - Initializer
    
    init(
        title: String = "",
        isTimerVersion: Bool = true,
        startDate: Date = Date(),
        endDate: Date = Date(),
        timerTime: Date = Date()
    ) {
        self.title = title
        self.isTimerVersion = isTimerVersion
        self.startDate = startDate
        self.endDate = endDate
        self.timerTime = timerTime
    }
}
