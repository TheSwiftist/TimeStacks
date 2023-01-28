//
//  TimeStackModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

final class TimeStackViewModel: ObservableObject, Identifiable {
    var id = UUID().uuidString
    let title: String
    let duration: Double
    
    @Published var offset: CGFloat = 0
    @Published var endSwipe: Bool = false
    
    init(title: String, duration:Double) {
        self.title = title
        self.duration = duration
    }
    
    // MARK: - Internal Methods
    
    func calculateTopOffset(index: CGFloat) -> CGFloat {
        return (index <= 2 ? index : 2) * 15
    }
}
