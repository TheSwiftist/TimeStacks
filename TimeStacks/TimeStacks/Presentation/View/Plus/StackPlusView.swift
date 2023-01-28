//
//  ContentView.swift
//  TimeStacks
//
//  Created by asong on 2022/11/06.
//

import SwiftUI

struct StackPlusView: View {
    // MARK: - Properties - Private
    
    @State private var title: String = ""
    @State private var isTimerVersion = true
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var timerTime = Date()
    private let data = StackData()
    
    var body: some View {
        VStack {
            navigationBarView
            Spacer().frame(height: 20)
            todayDateView
            Spacer().frame(height: 20)
            stackTitleView
            stackTitleInputView
            Spacer().frame(height: 20)
            timerSelectionView
            Spacer().frame(height: 20)
            Group {
                if isTimerVersion {
                    timerVersionView
                } else {
                    clockVersionView
                }
                Spacer().frame(height: 20)
                completionButtonView
                stackListView
            }
        }
    }
    
    var navigationBarView: some View {
        HStack {
            Spacer().frame(width: 30)
            Button("취소", action: {
            }).foregroundColor(.black)
                .font(.system(size: 14).weight(.heavy))
            Spacer()
            Text("New Stack")
                .font(.system(size: 16).weight(.heavy))
            Spacer()
            Button("저장", action: {
            }).foregroundColor(.black)
                .font(.system(size: 14).weight(.heavy))
            Spacer().frame(width: 30)
        }
    }
    var todayDateView: some View {
        HStack {
            Spacer()
            Text("2022.11.13")
                .font(.system(size: 11).weight(.heavy))
            Spacer().frame(width: 15)
        }
    }
    var stackTitleView: some View {
        HStack {
            Spacer().frame(width: 15)
            Text("Stack Title")
                .font(.system(size: 15).weight(.heavy))
            Spacer()
        }
    }
    var stackTitleInputView: some View {
        TextField("Stack의 title을 입력해 주세요.", text: $title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textCase(.none)
            .padding(.horizontal)
            .font(.system(size: 13))
    }
    var timerSelectionView: some View {
        HStack {
            Spacer().frame(width: 15)
            Text("Timer")
                .font(.system(size: 15).weight(.heavy))
            Spacer().frame(width: 30)
            Button("Timer ver.", action: {
                isTimerVersion = true
            }).font(.system(size: 13).weight(.heavy))
                .foregroundColor(.green)
            Spacer().frame(width: 15)
            Button("Clock ver.", action: {
                isTimerVersion = false
            }).font(.system(size: 13).weight(.heavy))
                .foregroundColor(.pink)
            Spacer()
        }
    }
    var timerVersionView: some View {
        Group {
            HStack {
                Spacer().frame(width: 15)
                Text("Start")
                    .font(.system(size: 13).weight(.heavy))
                Spacer()
            }
            DatePicker("", selection: $startDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
            Spacer().frame(height: 20)
            
            HStack {
                Spacer().frame(width: 15)
                Text("End")
                    .font(.system(size: 13).weight(.heavy))
                Spacer()
            }
            DatePicker("", selection: $endDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
    var clockVersionView: some View {
        // TODO
        Text("clock version")
            .font(.system(size: 15).weight(.heavy))
    }
    var completionButtonView: some View {
        HStack {
            Spacer()
            Button("완료", action: {
            }).font(.system(size: 14).weight(.heavy))
                .foregroundColor(.blue)
            Spacer().frame(width: 20)
        }
    }
    var stackListView: some View {
        List(data.stacks) { stack in
            StackTableRow(stack: stack)
        }
    }
}

struct StackData {
    let stacks = [
        Stack(title: "런닝 뛰기", isTimerType: true, startTime: "07:00", endTime: "07:30"),
        Stack(title: "아침 명상", isTimerType: false, startTime: "07:30", endTime: nil)
    ]
}

struct StackTableRow: View {
    let stack: Stack
    
    var body: some View {
        HStack {
            Text(stack.title)
                .font(.system(size: 13).weight(.heavy))
                .foregroundColor(.pink)
            Spacer()
            Text(" -> ")
                .font(.system(size: 13).weight(.heavy))
                .foregroundColor(.black)
            Spacer()
            Text("\(stack.startTime)")
                .font(.system(size: 13).weight(.heavy))
                .foregroundColor(.pink)
        }
    }
}

struct StackPlusView_Previews: PreviewProvider {
    static var previews: some View {
        StackPlusView()
    }
}
