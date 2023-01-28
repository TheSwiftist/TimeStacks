//
//  TimerViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2023/01/28.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject private var viewModel: TimerViewModel
    
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            TimerProgressView()
                .environmentObject(viewModel)
            Button {
                viewModel.timerTouched()
            } label: {
                Text(viewModel.progressText)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

private extension TimerView {
    struct TimerProgressView: View {
        @EnvironmentObject private var viewModel: TimerViewModel
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.white)
                Circle()
                    .trim(from: 0, to: CGFloat(min(viewModel.progress, 1)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear)
            }
        }
    }
}
