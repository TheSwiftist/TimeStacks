//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackView: View {
    // MARK: - Properties
    @EnvironmentObject var parentViewModel: TimeStacksMainViewModel
    private let viewModel: TimeStackViewModel
    
    // MARK: - Initializer
    init(viewModel: TimeStackViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View Body
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            let index = CGFloat(parentViewModel.getIndex(of: viewModel))
            let topOffset = viewModel.calculateTopOffset(index: index)
            
            ZStack {
                VStack {
                    Color.blue
                }
                .frame(width: width,
                       height: height / 3,
                       alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: -topOffset)
            }
        }
        .offset(x: viewModel.offset)
        .contentShape(Rectangle().trim(from: 0, to: viewModel.endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating(viewModel.$isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    handleSwiping(with: value)
                })
                .onEnded({ value in
                    handleSwipeEnded(with: value)
                })
        )
    }
}

// MARK: - Private Methods
extension TimeStackView {
    private func endSwipeActions() {
        withAnimation(.none) { viewModel.endSwipe = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = parentViewModel.displayedTimeStacks?.first {
                let _ = withAnimation {
                    parentViewModel.displayedTimeStacks?.removeFirst()
                }
            }
        }
    }
    
    private func handleSwiping(with value: GestureStateGesture<DragGesture, Bool>.Value) {
        let translation = value.translation.width
        viewModel.offset = (viewModel.isDragging ? translation : .zero)
    }
    
    private func handleSwipeEnded(with value: GestureStateGesture<DragGesture, Bool>.Value) {
        let width = getRect().width - 50
        let translation = value.translation.width
        let checkingStatus = (translation > 0 ? translation : -translation)
        
        func removeCard() {
            viewModel.offset = (translation > 0 ? width : -width) * 2
            viewModel.endSwipe = true
        }
        
        func reset() {
            viewModel.offset = .zero
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

// MARK: - PreviewProvider
struct TimeStackView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStackView(viewModel: TimeStackViewModel(title: "test",
                                                    duration: 1))
    }
}