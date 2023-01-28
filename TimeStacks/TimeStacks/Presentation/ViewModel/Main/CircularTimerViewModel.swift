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
    
    @Published var progressText: String = ""
    @Published var progress: Double = 0.0
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupTimer()
    }
}

// MARK: - Private Methods

private extension CircularTimerViewModel {
    func setupTimer() {
        timer
            .tryMap({ _ in
                try self.getNewProgressTime(currentTime: self.progress,
                                            incrementTime: 0.01,
                                            limitDuration: 1)
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
