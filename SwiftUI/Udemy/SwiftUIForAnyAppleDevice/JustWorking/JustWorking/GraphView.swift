//
//  GraphView.swift
//  JustWorking
//
//  Created by 김광수 on 2022/03/22.
//

import SwiftUI

struct GraphView: View {
    
    var steps: [Step] = [Step]()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    var totalSteps: Int {
        steps.map{ $0.count }.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                ForEach(steps, id: \.id) { step in
                    
                    let yValue = Swift.min(step.count/20, 300)
                    
                    VStack(alignment: .center) {
                        Text("\(step.date, formatter: Self.dateFormatter)")
                            .font(.caption2)
                            .foregroundColor(Color.white)
                        
                        Rectangle()
                            .fill(step.count > 4000 ? Color.red : .green)
                            .frame(width: 20, height: CGFloat(yValue), alignment: .bottom)
                        
                        Text("\(step.count)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                }
            }
            
            Text("Total Steps: \(totalSteps)")
                .padding(10)
                .opacity(0.5)
        }
        .padding(30)
        .background(Color.cyan)
        .cornerRadius(10)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
            Step(count: 4523, date: Date()),
            Step(count: 345, date: Date()),
            Step(count: 133, date: Date()),
            Step(count: 423, date: Date()),
            Step(count: 523, date: Date())
        ]
        
        GraphView(steps: steps)
    }
}
