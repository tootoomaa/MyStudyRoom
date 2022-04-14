//
//  ContentView.swift
//  GearsAndBelt
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // MARK: - MOTOR AND GEAR 1 AND 2 - Z AXIX ROTATION
            ZStack {
                Image("motor").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 120)
                    .offset(x: -120, y: 90)
                // motor gear 1
                GearView(gearImage: "doubleGear", gearWidth: 40, gearDegrees: 360, offsetGearX: -124, offsetGearY: 102, duration: 5)
                
                // Top left gear
                GearView(gearImage: "doubleGear", gearWidth: 100, gearDegrees: 360, offsetGearX: -124, offsetGearY: -280, duration: 7)
            } //: ZSTACK
            
            // MARK: - TOP BELT AND GEAR 3 -  AXIS ROTATION
            ZStack {
                // top belt
                BeltView(animateBelt: true, beltWidth: 352, beltHeight: 100, offsetBeltX: 0, offsetBeltY: -280, dashPhaseValue: -360, rotateDegree: 0)
                // top right gear - double gear
                GearView(gearImage: "doubleGear", gearWidth: 100, gearDegrees: 360, offsetGearX: 124, offsetGearY: -280, duration: 7)
            } //: ZSTACK
            
            // MARK: - GEAR 4, 5, 6 - Z AXIS ROTATION
            ZStack {
                // middle right gear - gear 4
                GearView(gearImage: "doubleGear", gearWidth: 100, gearDegrees: 360, offsetGearX: 124, offsetGearY: -70, duration: 5)
                
                GearView(gearImage: "doubleGear", gearWidth: 80, gearDegrees: -360, offsetGearX: 49, offsetGearY: -113, duration: 5)
                
                GearView(gearImage: "doubleGear", gearWidth: 100, gearDegrees: 360, offsetGearX: -6, offsetGearY: -80, duration: 5)
            }
            
            // MARK: - BELT - Z AXIS ROTATION
            ZStack {
                // belt 1 for the moter - long belt left side
                BeltView(animateBelt: true, beltWidth: 425, beltHeight: 48, offsetBeltX: -124, offsetBeltY: -90, rotateDegree: 90)
                // belt 2 - short belt right side
                BeltView(animateBelt: true, beltWidth: 258, beltHeight: 48, offsetBeltX: 124, offsetBeltY: -175, rotateDegree: 90)
            }
            
            // MARK: - GEAR 7 and BELT 3 - X ASIX Rotation
            ZStack {
                // middle fourth from the right gear 7
                GearView(gearImage: "singleGear", gearWidth: 100, gearDegrees: -360, offsetGearX: -63, offsetGearY: -85, rotateDegrees: 79, duration: 7, xAxis: 0, yAxis: 1, zAxis: 0)
                
                // middle small belt
                BeltView(animateBelt: true, beltWidth: 22, beltHeight: 120, dashPhaseValue: -40)
                    .rotation3DEffect(.degrees(70), axis: (x: 0, y: 1, z: 0))
                    .offset(x: -60, y: -33)
                
                // bottom right gear
                GearView(gearImage: "singleGear", gearWidth: 100, gearDegrees: -360, offsetGearX: 160, offsetGearY: 94, rotateDegrees: 79, duration: 7, xAxis: 0, yAxis: 1, zAxis: 0)
                
                // bottom right small belt
                BeltView(animateBelt: true, beltWidth: 22, beltHeight: 170, offsetBeltX: 0, offsetBeltY: -10, dashPhaseValue: -40, rotateDegree: 0)
                    .rotation3DEffect(.degrees(70), axis: (x: 0, y:1, z:0))
                    .offset(x: 162, y: 185)
                
                // bottom shaft
                ShaftView(width: 170).offset(x: 95, y: 260)
            }
            
            // MARK: - WORM GEAR AND Y AXIS ROTATION AND SHAFT VIEW
            ZStack {
                // worm gear
                WormGearsView().offset(x: 60, y: 30)
                // middle y axis gear
                GearView(gearImage: "singGear", gearWidth: 175, gearDegrees: 360, offsetGearX: 60, offsetGearY: 39, rotateDegrees: 84, duration: 7, xAxis: 1, yAxis: 0, zAxis: 0)
                // shaftView Connecting
                ShaftView(width: 120).offset(x: -13, y: 30)
            }
            
            // MARK: - FAN
            FanView()
                .offset(x: 0, y: 250)
                .frame(width: 140, height: 140)
            
        } //: TOP ZSTACK
        .background(Image("goldBackground").resizable().aspectRatio(contentMode: .fill).frame(width: 600, height: 1000))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
