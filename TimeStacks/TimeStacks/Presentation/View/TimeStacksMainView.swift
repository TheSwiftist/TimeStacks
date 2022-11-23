//
//  TimeStacksMainView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/10/31.
//

import SwiftUI

struct TimeStacksMainView: View {
    // MARK: - Properties
    @StateObject var viewModel: TimeStacksMainViewModel = TimeStacksMainViewModel(
        timeStackModels: [TimeStackViewModel(index: 0, title: "1", duration: 10),
                          TimeStackViewModel(index: 1, title: "2", duration: 10),
                          TimeStackViewModel(index: 2, title: "3", duration: 10),
                          TimeStackViewModel(index: 3, title: "4", duration: 10)]
    )
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            if let timeStacks = viewModel.displayedTimeStacks {
                ForEach(timeStacks) { timeStackViewModel in
                    TimeStackView(viewModel: timeStackViewModel)
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

// MARK: - PreviewProvider
struct TimeStacksMainView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStacksMainView()
    }
}
