//
//  MainQueue+Synchronous.swift
//  Msgr
//
//  Created by Aung Ko Min on 12/10/22.
//

import Foundation

internal extension Array {
    func executeIfPresent(_ closure: ([Element]) -> Void) {
        if !isEmpty {
            closure(self)
        }
    }
}
