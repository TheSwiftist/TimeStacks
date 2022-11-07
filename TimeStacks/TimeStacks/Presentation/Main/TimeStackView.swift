//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackView: View {
    let model: TimeStackModel
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            let index = CGFloat(model.index)
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

struct TimeStackView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStackView(model: TimeStackModel(index: 0,
                                            title: "test",
                                            duration: 1))
    }
}
