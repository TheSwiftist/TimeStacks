//
//  CircularTimerViewModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2023/01/28.
//

import SwiftUI
import Combine

final class CircularTimerViewModel: ObservableObject {
    // MARK: - Private Properties
    
    private var isRunning: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    // MARK: - Output
    
    @Published var progressText: String = "Press Me"
    @Published var progress: Double = 0.0
    
    // MARK: - Initializer
    
    init(increment: Double, duration: Double) {
        setupTimer(increment, duration)
    }
    
    // MARK: - Input
    
    func timerTouched() {
        isRunning.toggle()
    }
}

// MARK: - Private Methods

private extension CircularTimerViewModel {
    func setupTimer(_ increment: Double, _ totalDuration: Double) {
        timer
            .filter { _ in self.isRunning == true }
            .tryMap({ _ in
                try self.calculateProgress(currentTime: self.progress,
                                           incrementTime: increment,
                                           limitDuration: totalDuration)
            })
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                default:
                    self.timer.upstream.connect().cancel()
                }
            }, receiveValue: { [weak self] progress in
                guard let self = self else { return }
                self.progressText = progress.textFormat
                self.progress = progress
                self.isRunning = true
            })
            .store(in: &subscriptions)
    }
    
    func calculateProgress(currentTime: Double, incrementTime: Double, limitDuration: Double) throws -> Double {
        guard currentTime < limitDuration else {
            throw TimerError.reachedDuration
        }
        return currentTime + incrementTime
    }
}

// MARK: - Error

private extension CircularTimerViewModel {
    enum TimerError: Error {
        case reachedDuration
    }
}

// MARK: - Double Extension

fileprivate extension Double {
    var textFormat: String {
        return "\(Int((1-self)*100))"
    }
}
