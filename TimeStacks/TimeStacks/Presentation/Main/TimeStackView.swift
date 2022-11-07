//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackView: View {
    let model: TimeStackModel
    
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
        .contentShape(Rectangle())
    }
}


struct TimeStackView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStackView(model: TimeStackModel(index: 0, title: "test", duration: 1))
    }
}
