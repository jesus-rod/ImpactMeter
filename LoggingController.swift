//
//  LoggingController.swift
//  ImpactMeter
//
//  Created by Jesus Rodriguez on 02.05.21.
//

import SwiftyBeaver

struct LoggingController {

    let log = SwiftyBeaver.self

    static let shared = LoggingController()

    init() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }
}
