//
//  ContentView.swift
//  HeartRateWithAppleWatch
//
//  Created by 김광수 on 2021/04/08.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    let healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var value: Int = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("❤️")
                    .font(.system(size: 50))
                Spacer()
                
            }
            
            HStack{
                Text("\(value)")
                    .fontWeight(.regular)
                    .font(.system(size: 70))
                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .padding(.bottom, 28.0)
                Spacer()
            }
        }
        .padding()
        .onAppear(perform: start)
    }
    
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    //1. 심박수 모니터링에 대한 권한 획득
    func autorizeHealthKit() {
        // QuantityType Object를 생성하기 위해서 identifier정의
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        // 위에서 정의한 HealtkitType을 통해서 데이터를 읽을수 있는 권한 요청
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    //2. 심박수 조회에 대한 쿼리 생성 및 실행
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // 현재 사용중인 디바이스로부터 데이터 추출
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
        // 쿼리는 HealthKit Store로 부터 변경된 데이터를 리턴한다.
        // 쿼리가 종료될때 까지 진행된다.
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // 양을 표현해주는 간단한 셈플
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
        }
        
        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // 쿼리 실행
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        // 변수 초기화
        var lastHeartRate = 0.0
        
        // cycle and value assignment
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            
            self.value = Int(lastHeartRate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
