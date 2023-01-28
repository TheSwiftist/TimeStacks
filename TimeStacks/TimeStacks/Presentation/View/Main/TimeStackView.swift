//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI
import Combine

struct TimeStackView: View {
    // MARK: - Properties
    
    @EnvironmentObject var parentViewModel: TimeStacksMainViewModel
    @ObservedObject private var viewModel: TimeStackViewModel
    @GestureState private var isDragging = false
    
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
                
                CircularTimer()
                    .frame(width: width/3, height: height/2, alignment: .trailing)
                    .offset(x: 100, y: -topOffset)
            }
        }
        .offset(x: viewModel.offset)
        .contentShape(Rectangle().trim(from: 0, to: viewModel.endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    handleSwiping(with: value)
                    // TODO: - 여기서 팝업 띄우기 (삭제할건지 완료 처리 할건지)
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
        viewModel.offset = (isDragging ? translation : .zero)
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
