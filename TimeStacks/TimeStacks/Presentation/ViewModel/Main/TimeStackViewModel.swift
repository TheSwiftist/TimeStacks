//
//  TimeStackModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

final class TimeStackViewModel: ObservableObject, Identifiable {
    var id = UUID().uuidString
    private let title: String
    private let duration: Double
    
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
    
    func handleSwiping(isDragging: Bool,
                       value: GestureStateGesture<DragGesture, Bool>.Value) {
        let translation = value.translation.width
        offset = (isDragging ? translation : .zero)
    }
    
    func handleSwipeEnded(width: CGFloat,
                          value: GestureStateGesture<DragGesture, Bool>.Value) {
        let translation = value.translation.width
        let checkingStatus = (translation > 0 ? translation : -translation)
        
        func removeCard() {
            offset = (translation > 0 ? width : -width) * 2
            endSwipe = true
        }
        
        func reset() {
            offset = .zero
        }
        
        withAnimation {
            if checkingStatus > (width / 2) {
                removeCard()
            } else {
                reset()
            }
        }
    }
}
