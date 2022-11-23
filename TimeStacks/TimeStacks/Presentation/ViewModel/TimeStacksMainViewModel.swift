//
//  TimeStacksViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/15.
//

import Foundation

final class TimeStacksMainViewModel: ObservableObject {
    // MARK: - Properties
    @Published var timeStackViewModels: [TimeStackViewModel]
    @Published var displayedTimeStacks: [TimeStackViewModel]?
    
    // MARK: - Initializer
    init(timeStackModels: [TimeStackViewModel]) {
        self.timeStackViewModels = timeStackModels
        self.displayedTimeStacks = timeStackModels
    }
    
    // MARK: - Internal Methods
    func getIndex(of targetTimeStack: TimeStackViewModel) -> Int {
        return displayedTimeStacks?.firstIndex(where: { timeStack in
            return timeStack.id == targetTimeStack.id
        }) ?? 0
    }
}
