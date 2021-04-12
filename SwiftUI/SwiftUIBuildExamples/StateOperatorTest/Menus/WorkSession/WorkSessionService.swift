//
//  WorkSessionService.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/12.
//

import Foundation
import HealthKit

class WorkSessionService {
    
    let healthKitStore = HKHealthStore()
    
    init() {
        getAuthorizeHealthKit()
        
    }
    
    func getAuthorizeHealthKit() {
        
        // 불러올 건강데이터 타입 정의
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        ]
        
        healthKitStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (_, _) in
            
        }
        
    }
    
    func saveMockHeartData() {
        
        // 1. Create a heart rate BPM Sample
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let heartRateQuantity = HKQuantity(unit: HKUnit(from: "count/min"),
                                           doubleValue: Double(arc4random_uniform(80) + 100))
        let heartSample = HKQuantitySample(type: heartRateType,
                                           quantity: heartRateQuantity, start: Date(), end: Date())
        
        // 2. Save the sample in the store
        healthKitStore.save(heartSample, withCompletion: { (success, error) -> Void in
            if let error = error {
                print("Error saving heart sample: \(error.localizedDescription)")
            }
        })
    }
    
}
