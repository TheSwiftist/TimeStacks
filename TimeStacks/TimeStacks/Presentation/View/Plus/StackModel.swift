//
//  StackModel.swift
//  TimeStacks
//
//  Created by asong on 2022/11/14.
//

import Foundation

struct Stack: Identifiable {
    let id = UUID()
    let title: String
    let isTimerType: Bool
    let startTime: String
    let endTime: String?
}
