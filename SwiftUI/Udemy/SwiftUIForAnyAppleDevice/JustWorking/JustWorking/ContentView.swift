//
//  ContentView.swift
//  JustWorking
//
//  Created by 김광수 on 2022/03/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                GraphView(steps: steps)
                
                List(steps, id: \.id) { step in
                    VStack(alignment: .leading) {
                        Text(step.date, style: .date)
                            .opacity(0.5)
                        Text("\(step.count)")
                    }
                }
            }
            .navigationTitle("Just Walking")
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateStep { statisticsCollection in
                            // update the UI
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistisc(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateUIFromStatistisc(_ statisticsColleciton: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!                    // 7일 전
        let endDate = Date()
        
        statisticsColleciton.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            
            let count = statistics.sumQuantity()?.doubleValue(for: HKUnit.count())                      // 통계 값에서 카운트만 더해서 추출
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
