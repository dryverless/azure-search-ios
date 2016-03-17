//
//  DispatchQueue.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/15/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation

var GlobalMainQueue: dispatch_queue_t {

    return dispatch_get_main_queue()

}

var GlobalUserInteractiveQueue: dispatch_queue_t {

    return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)

}

var GlobalUserInitiatedQueue: dispatch_queue_t {

    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)

}

var GlobalUtilityQueue: dispatch_queue_t {

    return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)

}

var GlobalBackgroundQueue: dispatch_queue_t {

    return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)

}

//typealias GlobalBackgroundQueue: dispatch_queue_t = dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)