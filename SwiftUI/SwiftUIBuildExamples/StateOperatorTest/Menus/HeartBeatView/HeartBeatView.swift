//
//  HeartBeatView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/07.
//

import SwiftUI
import HealthKit

struct HeartBeatView: View {
    
    private var healthStore = HKHealthStore()
    
    let heartRateQuantity = HKUnit(from: "count/min")
    
    let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var vm = HeartBeatViewModel()
    
    @State private var value = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("❤️")
                    .font(.system(size: 50))
                Spacer()
                
            }
            
            HStack{
                Text("\(vm.heartbeat)")
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
        .onAppear {
            vm.start()
        }
    }
//
//    func fetchHealthData() -> Void {
//
//        if HKHealthStore.isHealthDataAvailable() {
//
//            let readData = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
//
//            healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
//
//                if success {
//
//                    guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
//                        fatalError("*** Unable to create a step count type ***")
//                    }
//
//                    //                    let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
//                    let sortByTime = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending: false)
//
//                    let query = HKSampleQuery(sampleType: quantityType,
//                                              predicate: nil,
//                                              limit: 10, sortDescriptors: [sortByTime]) {
//                        (query, results, error) in
//
//                        guard let resultsData = results else {
//                            print("Reuslt Error")
//                            return
//                        }
//
//                        if let lastData = resultsData.first {
//
//                            print(lastData)
//                        }
//
////                        let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
//
//                        print("===========")
//                        print(resultsData.first!)
//                        print("===========")
//                        /*
//                         (2021-04-07 13:33:16 +0900 - 2021-04-07 13:33:16 +0900), 80 count/min B60C1553-B9D1-4DA9-BFC7-57EE70AF911C "김광수의 Apple Watch" (7.3.3), "Watch5,4" (7.3.3) "Apple Watch" metadata: {
//                         HKMetadataKeyHeartRateMotionContext = 0;
//                         }
//                         */
//                    }
//
//                    healthStore.execute(query)
//
//                } else {
//                    print("Authorization failed")
//
//                }
//            }
//        }
//    }
//
//    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
//        // variable initialization
//        var lastHeartRate = 0.0
//
//        // cycle and value assignment
//        for sample in samples {
//            if type == .heartRate {
//                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
//            }
//
//            self.heartbeat = Int(lastHeartRate)
//        }
//    }
}

struct HeartBeatView_Previews: PreviewProvider {
    static var previews: some View {
        HeartBeatView()
    }
}
