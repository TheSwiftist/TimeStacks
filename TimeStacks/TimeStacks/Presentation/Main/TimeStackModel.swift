//
//  TimeStackModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import Foundation

struct TimeStackModel: Identifiable {
    var id = UUID().uuidString
    let title: String
    let duration: Double
}
