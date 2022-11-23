//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackView: View {
    @EnvironmentObject var mainViewModel: TimeStacksMainViewModel
    private let viewModel: TimeStackViewModel
    
    init(viewModel: TimeStackViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            let index = CGFloat(mainViewModel.getIndex(of: viewModel))
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
                    let translation = value.translation.width
                    viewModel.offset = (viewModel.isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            // remove card
                            viewModel.offset = (translation > 0 ? width : -width) * 2
                            viewModel.endSwipe = true
                        } else {
                            //reset
                            viewModel.offset = .zero
                        }
                    }
                })
        )
    }
}

// MARK: - Private Methods
extension TimeStackView {
    private func endSwipeActions() {
        withAnimation(.none) { viewModel.endSwipe = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = mainViewModel.displayedTimeStacks?.first {
                let _ = withAnimation {
                    mainViewModel.displayedTimeStacks?.removeFirst()
                }
            }
        }
    }
}

struct TimeStackView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStackView(viewModel: TimeStackViewModel(index: 0,
                                            title: "test",
                                            duration: 1))
    }
}
