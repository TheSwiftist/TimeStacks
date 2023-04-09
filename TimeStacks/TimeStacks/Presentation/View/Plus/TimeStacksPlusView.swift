//
//  ContentView.swift
//  TimeStacks
//
//  Created by asong on 2022/11/06.
//

import SwiftUI

struct TimeStacksPlusView: View {
    // MARK: - Properties - Private
    
    @StateObject private var viewModel: TimeStackPlusViewModel = TimeStackPlusViewModel()
    private let data = StackExampleData() // 추후 삭제 예정
    
    // MARK: - Property - Internal
    
    var body: some View {
        VStack {
            navigationBarView
            Spacer().frame(height: 20)
            stackTitleView
            Spacer().frame(height: 20)
            stackItemTitleView
            stackTitleInputView
            Spacer().frame(height: 20)
            timerSelectionView
            Spacer().frame(height: 20)
            Group {
                if viewModel.newStackItem.isTimerVersion {
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
    
    // MARK: - View Computation Properties - Private
    
    private var navigationBarView: some View {
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
    
    private var stackTitleView: some View {
        HStack {
            TextField("공부 Stack", text: $viewModel.stackTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textCase(.none)
                .padding(.horizontal)
                .font(.system(size: 15))
                .foregroundColor(.black)
        }
    }
    
    private var stackItemTitleView: some View {
        HStack {
            Spacer().frame(width: 15)
            Text("Stack Item Title")
                .font(.system(size: 15).weight(.heavy))
            Spacer()
        }
    }
    
    private var stackTitleInputView: some View {
        TextField("Stack의 title을 입력해 주세요.", text: $viewModel.newStackItem.title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textCase(.none)
            .padding(.horizontal)
            .font(.system(size: 13))
    }
    
    private var timerSelectionView: some View {
        HStack {
            Spacer().frame(width: 15)
            Text("Timer")
                .font(.system(size: 15).weight(.heavy))
            Spacer().frame(width: 30)
            
            Button("Timer ver.", action: {
                viewModel.newStackItem.isTimerVersion = true
            }).font(viewModel.newStackItem.isTimerVersion ? .system(size: 17).weight(.heavy) : .system(size: 15).weight(.heavy))
                .foregroundColor(.green)
            Spacer().frame(width: 15)
            
            Button("Clock ver.", action: {
                viewModel.newStackItem.isTimerVersion = false
            }).font(viewModel.newStackItem.isTimerVersion ? .system(size: 13).weight(.heavy) : .system(size: 15).weight(.heavy))
                .foregroundColor(.pink)
            Spacer()
        }
    }
    
    private var timerVersionView: some View {
        Group {
            HStack {
                Spacer().frame(width: 15)
                Text("Start")
                    .font(.system(size: 13).weight(.heavy))
                Spacer()
            }
            DatePicker("", selection: $viewModel.newStackItem.startDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
            Spacer().frame(height: 20)
            
            HStack {
                Spacer().frame(width: 15)
                Text("End")
                    .font(.system(size: 13).weight(.heavy))
                Spacer()
            }
            DatePicker("", selection: $viewModel.newStackItem.endDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
    
    private var clockVersionView: some View {
        // TODO
        Text("clock version")
            .font(.system(size: 15).weight(.heavy))
    }
    
    private var completionButtonView: some View {
        HStack {
            Spacer()
            Button("완료", action: {
                viewModel.saveNewTimeStackItem()
            }).font(.system(size: 14).weight(.heavy))
                .foregroundColor(.blue)
            Spacer().frame(width: 20)
        }
    }
    
    private var stackListView: some View {
        List(data.stacks) { stack in
            StackTableRow(stack: stack)
        }
    }
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
        TimeStacksPlusView()
    }
}

// 데이터베이스 연결 이후 삭제 예정
struct StackExampleData {
    let stacks = [
        Stack(title: "런닝 뛰기", isTimerType: true, startTime: "07:00", endTime: "07:30"),
        Stack(title: "아침 명상", isTimerType: false, startTime: "07:30", endTime: nil)
    ]
}
