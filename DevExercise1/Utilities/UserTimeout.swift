//
//  UserTimeout.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/23/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

class UserTimeout: UIApplication {
        private var timeoutInSeconds: TimeInterval {
           // 30 seconds
           return 200*60
       }

       private var idleTimer: Timer?
       // reset the timer because there was user interaction
       private func resetIdleTimer() {
           if let idleTimer = idleTimer {
               idleTimer.invalidate()
           }
           idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                            target: self,
                                            selector: #selector(UserTimeout.timeHasExceeded),
                                            userInfo: nil,
                                            repeats: false
           )
       }

       // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
       @objc private func timeHasExceeded() {
           NotificationCenter.default.post(name: .appTimedOut,
                                           object: nil
           )
       }

       override func sendEvent(_ event: UIEvent) {

           super.sendEvent(event)

        if idleTimer != nil {
               self.resetIdleTimer()
           }

        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                   self.resetIdleTimer()
               }
           }
       }

}
