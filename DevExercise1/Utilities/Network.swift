//
//  Network.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Reachability

//Reachability
//declare this property where it won't go out of scope relative to your listener
private var reachability: Reachability!

public protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

public protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
    var connectionStatus: Bool { get }
}

// Declaring default implementation of adding/removing observer
extension ReachabilityObserverDelegate {

    /** Subscribe on reachability changing */
    public func addReachabilityObserver() throws {
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
    public func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

public class InternetConnectivity: ReachabilityObserverDelegate {

    public var connectionStatus = true

    required init() {
        try? addReachabilityObserver()
    }
    deinit {
        removeReachabilityObserver()
    }
    public func reachabilityChanged(_ isReachable: Bool) {
        self.connectionStatus = isReachable
    }
}
