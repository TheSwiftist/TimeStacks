//
//  ContentView.swift
//  TimeStacks
//
//  Created by asong on 2022/11/06.
//

import SwiftUI

struct StackPlusView: View {
    @State private var title: String = ""
    private let data = StackData()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 30)
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
                Spacer()
                    .frame(width: 30)
            }
            
            Spacer().frame(height: 20)
            
            HStack{
                Spacer()
                Text("2022.11.13")
                    .font(.system(size: 11).weight(.heavy))
                Spacer()
                    .frame(width: 15)
            }
            
            Spacer().frame(height: 20)
            
            HStack{
                Spacer()
                    .frame(width: 15)
                Text("Stack Title")
                    .font(
                        .system(size: 15)
                            .weight(.heavy)
                    )
                Spacer()
            }
            
            TextField("Stack의 title을 입력해 주세요.", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textCase(.none)
                .padding(.horizontal)
                .font(.system(size: 13))
            
            Spacer().frame(height: 20)
            
            HStack {
                Spacer()
                    .frame(width: 15)
                Text("Timer")
                    .font(
                        .system(size: 15)
                            .weight(.heavy)
                    )
                Spacer().frame(width: 30)
                Button("Timer ver.", action: {
                }).font(
                    .system(size: 13)
                        .weight(.heavy)
                ).foregroundColor(.green)
                Spacer().frame(width: 15)
                Button("Clock ver.", action: {
                }).font(
                    .system(size: 13)
                        .weight(.heavy)
                ).foregroundColor(.pink)
                Spacer()
                Spacer()
            }

            Spacer()
            
            List(data.stacks) { stack in
                StackRow(stack: stack)
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

struct StackRow: View {
    let stack: Stack
    
    var body: some View {
        HStack {
            Text(stack.title)
                .font(
                    .system(size: 13)
                        .weight(.heavy)
                ).foregroundColor(.pink)
            Spacer()
            Text(" -> ")
                .font(
                    .system(size: 13)
                        .weight(.heavy)
                    
                ).foregroundColor(.black)
            Spacer()
            Text("\(stack.startTime)")
                .font(
                    .system(size: 13)
                        .weight(.heavy)
                ).foregroundColor(.pink)
        }
    }
}

struct StackPlusView_Previews: PreviewProvider {
    static var previews: some View {
        StackPlusView()
    }
}
