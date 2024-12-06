//
//  EnvironmentValuesStore.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 04.12.24.
//

import Foundation

@Observable
class EnvironmentValuesStore {
    var showAlert: Bool = false
    var showHistoryDetail: Bool = false
    var historyData: String = ""
    var noUser: Bool = false
    var newHistoryEntriesReally: Bool = false
    var newHistoryEntriesThinkSolve: Bool = false
}
