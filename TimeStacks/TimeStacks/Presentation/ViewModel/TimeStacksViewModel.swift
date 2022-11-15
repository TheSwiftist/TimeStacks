//
//  TimeStacksViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/15.
//

import Foundation

final class TimeStacksViewModel: ObservableObject {
    @Published var timeStackModels: [TimeStackModel]
    @Published var displayedTimeStacks: [TimeStackModel]?
    
    init(timeStackModels: [TimeStackModel]) {
        self.timeStackModels = timeStackModels
        self.displayedTimeStacks = timeStackModels
    }
    
    func getIndex(of targetTimeStack: TimeStackModel) -> Int {
        return displayedTimeStacks?.firstIndex(where: { timeStack in
            return timeStack.id == targetTimeStack.id
        }) ?? 0
    }
}
