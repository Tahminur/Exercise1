//
//  InternetConnection.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Reachability
import Network

public class InternetConnection{
    let monitor = NWPathMonitor()
    
    func setup() -> String? {
        var ErrorMsg:String? = nil
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                ErrorMsg = "We have Internet"
            }
            else{
                ErrorMsg = "No Internet"
            }
        }
        return ErrorMsg
    }
}

fileprivate var reachability:Reachability!


protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool) -> String?
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

extension ReachabilityObserverDelegate{
    func addReachabilityObserver() throws {
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

class TestConnection:ReachabilityObserverDelegate{
    func reachabilityChanged(_ isReachable: Bool) -> String? {
        if !isReachable {
            return "No Internet Connection"
        }
        return nil
    }
    
    required init(){
        try? addReachabilityObserver()
    }
    deinit {
        removeReachabilityObserver()
    }
}
