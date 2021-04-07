//
//  PrancerciseWorkout.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/07.
//

import SwiftUI

struct PrancerciseWorkout {
    
    /*
     PrancerciseWorkout is the model the app uses to store information related to a workout.
     The app creates one every time you tap the Done button after finishing your Prancercise session.
     
     Each PrancerciseWorkout keeps track of its:
     1.Start and end time
     2.Duration
     3.Total calories burned
     */
    
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    var totalEnergyBurned: Double {
        let prancerciseCaloriesPerHour: Double = 450
        let hours: Double = duration / 3600
        let totalCalories = prancerciseCaloriesPerHour * hours
        return totalCalories
    }
}
