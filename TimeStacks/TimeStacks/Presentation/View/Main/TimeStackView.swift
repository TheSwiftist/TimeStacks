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
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    init(viewModel: TimeStackViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            let index = CGFloat(mainViewModel.getIndex(of: viewModel))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack {
                VStack {
                    Color.blue
                }
                .frame(width: width, // - topOffset
                       height: height / 3,
                       alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: -topOffset)
            }
        }
        .offset(x: offset)
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            // remove card
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipe = true
                        } else {
                            //reset
                            offset = .zero
                        }
                    }
                })
        )
    }
}

// MARK: - Private Methods
extension TimeStackView {
    private func endSwipeActions() {
        withAnimation(.none) { endSwipe = true }
        
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
