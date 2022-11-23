//
//  TimeStacksViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/15.
//

import Foundation

final class TimeStacksMainViewModel: ObservableObject {
    @Published var timeStackModels: [TimeStackViewModel]
    @Published var displayedTimeStacks: [TimeStackViewModel]?
    
    init(timeStackModels: [TimeStackViewModel]) {
        self.timeStackModels = timeStackModels
        self.displayedTimeStacks = timeStackModels
    }
    
    func getIndex(of targetTimeStack: TimeStackViewModel) -> Int {
        return displayedTimeStacks?.firstIndex(where: { timeStack in
            return timeStack.id == targetTimeStack.id
        }) ?? 0
    }
}
