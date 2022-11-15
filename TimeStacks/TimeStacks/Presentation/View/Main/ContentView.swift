//
//  ContentView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: TimeStacksViewModel = TimeStacksViewModel(timeStackModels: [
        TimeStackModel(index: 0, title: "1", duration: 10),
        TimeStackModel(index: 1, title: "2", duration: 10),
        TimeStackModel(index: 2, title: "3", duration: 10),
        TimeStackModel(index: 3, title: "4", duration: 10)
    ])
    var body: some View {
        ZStack {
            if let timeStacks = viewModel.displayedTimeStacks {
                ForEach(timeStacks) { model in
                    TimeStackView(model: model)
                        .environmentObject(viewModel)
                }
            } else {
                ProgressView()
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
