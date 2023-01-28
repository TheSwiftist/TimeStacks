//
//  CircularTimerViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2023/01/28.
//

import SwiftUI
import Combine

final class CircularTimerViewModel: ObservableObject {
    private enum TimerError: Error {
        case reachedDuration
    }
    
    @Published var progressText: String = "Press Me"
    @Published var progress: Double = 0.0
    
    private var isRunning: Bool = false
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupTimer(increment: 0.01, totalDuration: 1)
    }
    
    func timerTouched() {
        isRunning.toggle()
    }
}

// MARK: - Private Methods

private extension CircularTimerViewModel {
    func setupTimer(increment: Double, totalDuration: Double) {
        timer
            .filter { _ in self.isRunning == true }
            .tryMap({ _ in
                try self.getNewProgressTime(currentTime: self.progress,
                                            incrementTime: increment,
                                            limitDuration: totalDuration)
            })
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                default:
                    self.timer.upstream.connect().cancel()
                }
            }, receiveValue: { [weak self] newValue in
                guard let self = self else { return }
                self.progressText = self.convertToTimeText(time: newValue)
                self.progress = newValue
                self.isRunning = true
            })
            .store(in: &subscriptions)
    }
    
    func convertToTimeText(time: Double) -> String {
        return "\(Int((1-time)*100))"
    }
    
    func getNewProgressTime(currentTime: Double, incrementTime: Double, limitDuration: Double) throws -> Double {
        guard currentTime < limitDuration else {
            throw TimerError.reachedDuration
        }
        return currentTime + incrementTime
    }
}
