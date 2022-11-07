//
//  ContentView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    let stacks: [TimeStackModel] = [
        TimeStackModel(title: "1", duration: 10),
        TimeStackModel(title: "2", duration: 10),
        TimeStackModel(title: "3", duration: 10),
        TimeStackModel(title: "4", duration: 10)
    ]
    var body: some View {
        ZStack {
            ForEach(stacks) { stack in
                TimeStackView()
            }
        }
        .padding(.top, 100)
        .padding()
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
