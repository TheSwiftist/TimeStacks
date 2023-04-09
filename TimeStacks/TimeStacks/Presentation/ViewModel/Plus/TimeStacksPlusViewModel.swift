//
//  TimeStacksPlusViewModel.swift
//  TimeStacks
//
//  Created by asong on 2023/01/28.
//

import SwiftUI

final class TimeStackPlusViewModel {
    // MARK: - Properties - Internal
    var stackTitle: String = ""
    @Published var newStackItem: StackItem = StackItem()
}

// MARK: - Internal Methods

extension TimeStackPlusViewModel: PlusViewModelType {
    func calculateTopOffset(index: CGFloat) -> CGFloat {
        return (index <= 2 ? index : 2) * 15
    }
    
    func saveNewTimeStackItem() {
        print("newStackItem : \(newStackItem.title)")
    }
}
