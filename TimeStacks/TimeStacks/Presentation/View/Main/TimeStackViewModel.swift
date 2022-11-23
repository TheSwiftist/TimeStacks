//
//  TimeStackModel.swift
//  TimeStacks
//
//  Created by Jun Bang on 2022/11/06.
//

import Foundation

struct TimeStackViewModel: Identifiable {
    var id = UUID().uuidString
    let index: Int
    let title: String
    let duration: Double
}
