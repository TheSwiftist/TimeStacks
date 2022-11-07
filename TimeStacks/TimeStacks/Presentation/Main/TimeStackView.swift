//
//  TimeStackView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import SwiftUI

struct TimeStackView: View {
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack {
                    Color.blue
                }
                .frame(maxWidth: reader.size.width,
                       maxHeight: 200,
                       alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 20)
            }
        }
    }
}


struct TimeStackView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStackView()
    }
}
