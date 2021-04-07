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
    
    @State private var value = 0
    
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
                    .onReceive(timer) { _ in
                        fetchHealthData()
                    }
                
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
            
        }
    }
    
    func fetchHealthData() -> Void {
        
        if HKHealthStore.isHealthDataAvailable() {
            
            let readData = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
            
            healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                
                if success {
                    
                    //                    let calendar = NSCalendar.current
                    //
                    //                    var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
                    //
                    //                    let offset = (7 + anchorComponents.weekday! - 2) % 7
                    //
                    //                    anchorComponents.day! -= offset
                    //                    anchorComponents.hour = 2
                    //
                    //                    guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
                    //                        fatalError("*** unable to create a valid date from the given components ***")
                    //                    }
                    //
                    //                    let interval = NSDateComponents()
                    //                    interval.second = 1
                    //
                    //                    let endDate = Date()
                    //
                    //                    guard let startDate = calendar.date(byAdding: .month, value: -1, to: endDate) else {
                    //                        fatalError("*** Unable to calculate the start date ***")
                    //                    }
                    
                    guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
                        fatalError("*** Unable to create a step count type ***")
                    }
                    
                    //                    let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
                    let sortByTime = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending: false)
                    
                    let query = HKSampleQuery(sampleType: quantityType,
                                              predicate: nil,
                                              limit: 10, sortDescriptors: [sortByTime]) {
                        (query, results, error) in
                        
                        guard let resultsData = results else {
                            print("Reuslt Error")
                            return
                        }
                        
                        //                        let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
                        
                        print(resultsData.first)
                        /*
                         (2021-04-07 13:33:16 +0900 - 2021-04-07 13:33:16 +0900), 80 count/min B60C1553-B9D1-4DA9-BFC7-57EE70AF911C "김광수의 Apple Watch" (7.3.3), "Watch5,4" (7.3.3) "Apple Watch" metadata: {
                         HKMetadataKeyHeartRateMotionContext = 0;
                         }
                         */
                    }
                    
                    healthStore.execute(query)
                    
                } else {
                    print("Authorization failed")
                    
                }
            }
        }
    }
    
    //
    //    private func autorizeHealthKit() {
    //        let healthKitTypes: Set = [
    //            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
    //
    //        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    //    }
    //
    //    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
    //
    //        // We want data points from our current device
    //        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
    //
    //        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
    //        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
    //            query, samples, deletedObjects, queryAnchor, error in
    //
    //            // A sample that represents a quantity, including the value and the units.
    //            guard let samples = samples as? [HKQuantitySample] else {
    //                return
    //            }
    //
    //            self.process(samples, type: quantityTypeIdentifier)
    //
    //        }
    //
    //        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
    //        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
    //
    //        query.updateHandler = updateHandler
    //
    //        // query execution
    //        healthStore.execute(query)
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
    //            self.value = Int(lastHeartRate)
    //        }
    //    }
    //
    //    func fetchHealthData() -> Void {
    //        let healthStore = HKHealthStore()
    //        if HKHealthStore.isHealthDataAvailable() {
    //            let readData = Set([
    //                HKObjectType.quantityType(forIdentifier: .heartRate)!
    //            ])
    //
    //            healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
    //                if success {
    //                    let calendar = NSCalendar.current
    //
    //                    var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
    //
    //                    let offset = (7 + anchorComponents.weekday! - 2) % 7
    //
    //                    anchorComponents.day! -= offset
    //                    anchorComponents.hour = 2
    //
    //                    guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
    //                        fatalError("*** unable to create a valid date from the given components ***")
    //                    }
    //
    //                    let interval = NSDateComponents()
    //                    interval.minute = 30
    //
    //                    let endDate = Date()
    //
    //                    guard let startDate = calendar.date(byAdding: .month, value: -1, to: endDate) else {
    //                        fatalError("*** Unable to calculate the start date ***")
    //                    }
    //
    //                    guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
    //                        fatalError("*** Unable to create a step count type ***")
    //                    }
    //
    //                    let query = HKStatisticsCollectionQuery(quantityType: quantityType,
    //                                                            quantitySamplePredicate: nil,
    //                                                            options: .discreteAverage,
    //                                                            anchorDate: anchorDate,
    //                                                            intervalComponents: interval as DateComponents)
    //
    //                    query.initialResultsHandler = {
    //                        query, results, error in
    //
    //                        guard let statsCollection = results else {
    //                            fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
    //
    //                        }
    //
    //                        statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
    //                            if let quantity = statistics.averageQuantity() {
    //                                let date = statistics.startDate
    //                                //for: E.g. for steps it's HKUnit.count()
    //                                let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
    //                                print("done")
    //                                print(value)
    //                                print(date)
    //
    //                            }
    //                        }
    //
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
    
    
    //    func motitorStart() {
    //        if (HKHealthStore.isHealthDataAvailable()){
    //
    //            self.healthStore.requestAuthorization(toShare: nil, read:[heartRateType], completion:{(success, error) in
    //                let sortByTime = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending:false)
    //
    //                let timeFormatter = DateFormatter()
    //                timeFormatter.dateFormat = "hh:mm:ss"
    //
    //                let dateFormatter = DateFormatter()
    //                dateFormatter.dateFormat = "MM/dd/YYYY"
    //
    //                let query = HKSampleQuery(sampleType: heartRateType, predicate:nil, limit:1, sortDescriptors: [sortByTime], resultsHandler:{(query, results, error) in
    //                    guard let results = results else { return }
    //                    for quantitySample in results {
    //
    //                        let quantity = (quantitySample as! HKQuantitySample).quantity
    //                        let heartRateUnit = HKUnit(from: "count/min")
    //
    //                        //                        csvString.extend("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))\n")
    //                        //                        println("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))")
    //                        //                        csvString += "\(timeFormatter.string(from: quantitySample.startDate)),\(dateFormatter.string(from: quantitySample.startDate)),\(quantity.doubleValue(for: heartRateUnit))\n"
    //
    //                        self.value = Int(quantity.doubleValue(for: heartRateUnit))
    //                        print(value)
    //
    //                        //                        print("\(timeFormatter.string(from: quantitySample.startDate)),\(dateFormatter.string(from: quantitySample.startDate)),\(quantity.doubleValue(for: heartRateUnit))")
    //                    }
    //                })
    //
    //                self.healthStore.execute(query)
    //            })
    //        }
    //    }
}

struct HeartBeatView_Previews: PreviewProvider {
    static var previews: some View {
        HeartBeatView()
    }
}
