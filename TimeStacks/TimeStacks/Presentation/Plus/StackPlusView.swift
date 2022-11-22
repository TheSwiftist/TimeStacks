//
//  ContentView.swift
//  TimeStacks
//
//  Created by asong on 2022/11/06.
//

import SwiftUI

struct StackPlusView: View {
    @State private var title: String = ""
    @State private var isTimerVersion = true
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var timerTime = Date()
    private let data = StackData()
    
    var body: some View {
        VStack {
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
            
            Spacer().frame(height: 20)
            
            HStack {
                Spacer()
                Text("2022.11.13")
                    .font(.system(size: 11).weight(.heavy))
                Spacer().frame(width: 15)
            }
            
            Spacer().frame(height: 20)
            
            HStack {
                Spacer().frame(width: 15)
                Text("Stack Title")
                    .font(.system(size: 15).weight(.heavy))
                Spacer()
            }
            
            TextField("Stack의 title을 입력해 주세요.", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textCase(.none)
                .padding(.horizontal)
                .font(.system(size: 13))
            
            Spacer().frame(height: 20)
            
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
            
            Spacer().frame(height: 20)
            
            Group {
                if isTimerVersion {
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
                } else {
                    
                }
                
                Spacer().frame(height: 20)
                
                HStack {
                    Spacer()
                    Button("완료", action: {
                    }).font(.system(size: 14).weight(.heavy))
                        .foregroundColor(.blue)
                    Spacer().frame(width: 20)
                }
                
                List(data.stacks) { stack in
                    StackTableRow(stack: stack)
                }
            }
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
