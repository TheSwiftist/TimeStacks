//
//  CircularTimeView.swift
//  TimeStacks
//
//  Created by Jun Bang on 2023/01/28.
//

import SwiftUI

struct CircularTimer: View {
    @State private var progress: Double = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            CircularProgressView(progress: $progress)
            Text("\(Int((1-progress)*100))")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onReceive(timer) { _ in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.upstream.connect().cancel()
            }
        }
    }
}


struct CircularProgressView: View {
    @Binding var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(.white)
            Circle()
                .trim(from: 0, to: CGFloat(min(self.progress, 1)))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear)
        }
    }
}


struct CircularTimer_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimer()
    }
}
