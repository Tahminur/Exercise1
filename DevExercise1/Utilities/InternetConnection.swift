//
//  InternetConnection.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Network

public class InternetConnection{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.main
    var status:String?
    
    public static var shared:InternetConnection = InternetConnection()
    
    init(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                self.status = nil
            }
            else{
                self.status = "No Internet Connection"
            }
        }
        monitor.start(queue: queue)
    }
}

