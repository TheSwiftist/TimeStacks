//
//  TimeStackModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackViewModel: Identifiable {
    var id = UUID().uuidString
    let index: Int
    let title: String
    let duration: Double
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    // MARK: - Internal Methods
    func calculateTopOffset(index: CGFloat) -> CGFloat {
        return (index <= 2 ? index : 2) * 15
    }
}
