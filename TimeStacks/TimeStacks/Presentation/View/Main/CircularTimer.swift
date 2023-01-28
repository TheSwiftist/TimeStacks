//
//  CircularTimeView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2023/01/28.
//

import SwiftUI

struct CircularTimer: View {
    @ObservedObject private var viewModel: CircularTimerViewModel
    
    init(viewModel: CircularTimerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            CircularProgressView()
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

private extension CircularTimer {
    struct CircularProgressView: View {
        @EnvironmentObject private var viewModel: CircularTimerViewModel
        
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
